//
//  Networking.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import SwiftyJSON
import ObjectMapper

class OnlineProvider<Target> where Target: Moya.TargetType {
    
    let online: Observable<Bool>         // 是否有网络
    let provider: MoyaProvider<Target>   // 请求管理
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         online: Observable<Bool> = ReachabilityManager.shared.connectedToInternet()) {
        
        self.online = online
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }
    
    /// 统一的网络请求
    func request(_ target: Target) -> Observable<Moya.Response> {
        let actualRequest = provider.rx.request(target)
        return online
            .ignore(value: false)// 等我们上线后再说
            .map({ (flag) -> (Bool) in
                debugPrints("是否有网络请求---\(flag)")
                return flag
            })
            .take(1)               // 使用1确保API只调用一次
            .flatMap { (_) in      // 将在线状态转换为网络请求
                return actualRequest.filterSuccessfulStatusCodes() // 过滤掉状态码不符合的
                    .do(onSuccess: { (response) in
                        do {
                            let value = try JSON(response.mapJSON())
                            debugPrints(value)
                            let msg = value["msg"].stringValue
                            let success = value["success"].boolValue
                            if (msg == "Token invalid" || msg == "No incoming token") && success == false {
                                //AuthManager.removeToken()  // token 失效
                            }
                        }catch let error {
                            debugPrints("接口请求失败---\(error)")
                        }
                    }, onError: { (error) in
                        if let error = error as? MoyaError {
                            switch error {
                            case .statusCode(let response):
                                if response.statusCode == 401 {
                                    //AuthManager.removeToken()  // Unauthorized
                                }
                            default: break
                            }
                        }
                    })
            }
            .retryWhen({ (e) in
                e.enumerated()
                    .flatMap { (attempt, error) -> Observable<Int> in
                        debugPrints("重连接---\(attempt)")
                        if attempt >= 3 {
                            debugPrints("重连接end---\(attempt)")
                            return Observable.error(error)
                        }else {
                            debugPrints("重连接start---\(attempt)")
                            return Observable<Int>.timer(Double(attempt + 1), scheduler: MainScheduler.instance).take(1)
                        }
                }
            })
        // 请求出差尝试几次
        // 第一次重试 1s
        // 第二次重试 2s
        // 第三次重试 3s
    }
    
}

protocol NetworkingType {
    associatedtype T: TargetType
    var provider: OnlineProvider<T> {get}
}

struct Networking: NetworkingType {
    typealias T = WebAPI
    var provider: OnlineProvider<WebAPI>
}

extension Networking {
    static func networking() -> Networking {
        return Networking(provider: newProvider(plugins))
    }
}

// MARK: - 公共接口
extension Networking {
    func request(_ target: WebAPI) -> Observable<Moya.Response> {
        return self.provider.request(target)
    }
}

extension Networking {
    
    static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint where T: TargetType, T: WebAPIType {
        return { target in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            // 签署所有非xapp，非xauth令牌请求
            return endpoint
        }
    }
    
    static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
        return .never
    }
    
    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        if Configs.Network.loggingEnabled == true {
            plugins.append(NetworkLoggerPlugin(verbose: true))
        }
        return plugins
    }
    
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest()
                request.httpShouldHandleCookies = false
                request.timeoutInterval = 10
                closure(.success(request))
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

private func newProvider<T>(_ plugins: [PluginType], xAccessToken: String? = nil) -> OnlineProvider<T> where T: WebAPIType {
    return OnlineProvider(endpointClosure: Networking.endpointsClosure(xAccessToken),
                          requestClosure: Networking.endpointResolver(),
                          stubClosure: Networking.APIKeysBasedStubBehaviour,
                          plugins: plugins)
}
