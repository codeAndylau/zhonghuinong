//
//  WebAPI.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import MBProgressHUD
import ObjectMapper
import SwiftyJSON
import Moya

protocol WebAPIType {
    var addXAuth: Bool { get }
}

enum WebAPI {
    
    /// 微信登录
    case wechatLogin(_ p: [String: Any])
    case psdLogin(_ p: [String: Any])
    
    /// 私家农场
    case farmLand(_ p: [String: Any])
    /// 取得农场传感器的值
    case farmSensordata(_ p: [String: Any])
    
    case xxx(_ p: [String: Any])
}

extension WebAPI: TargetType, WebAPIType {
    
    var baseURL: URL {
        return Configs.Network.debugUrl
    }
    
    var path: String {
        switch self {
        case .wechatLogin(_): return "/api/User/wechatapp"
        case .farmLand(_): return "/api/Farm/land"
        case .farmSensordata(_): return "/api/Farm/sensordata"
            
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .wechatLogin(_):
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .wechatLogin(let p):
            return .requestData(dictToData(dict: p)) //参数放在HttpBody中
        case .farmLand(let p),
             .farmSensordata(let p):
            return .requestParameters(parameters: p, encoding: URLEncoding.default) // 拼接在url中
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
    
    var addXAuth: Bool {
        switch self {
        default:
            return true
        }
    }
    
}

let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    switch type {
    case .began:
        MBProgressHUD.hide(for: vc.view, animated: false)
        MBProgressHUD.showAdded(to: vc.view, animated: true)
    case .ended:
        MBProgressHUD.hide(for: vc.view, animated: true)
    }
}

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<WebAPI>.RequestResultClosure) -> Void in
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 10
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

struct WebAPITool {
    
    static let shared = WebAPITool()
    static let provider = MoyaProvider<WebAPI>(requestClosure: timeoutClosure)
    static let LoadingProvider = MoyaProvider<WebAPI>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])
    
    /// 请求通用接口
    static func request(_ target: WebAPI, complete: @escaping (JSON) ->Void, failure: @escaping (String) ->Void) {
        provider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    let _ = try response.filterSuccessfulStatusCodes() // 只返回200-299的成功状态吗
                    let value = try JSON(response.mapJSON())
                    debugPrints("通用接口数据---\(response)--\(value)")
                    complete(value)
                }catch let error {
                    failure(error.localizedDescription) // 服务器连接成功，但数据返回错误（同时会返回错误信息）
                }
            case let .failure(error):
                failure(error.localizedDescription) // 服务器连接不上，网络异常等（同时会返回错误信息。必要的话，还可以在此增加自动重新请求的机制。）
            }
        }
    }
    
    /// 请求JSON数据
    static func requestJSON(_ target: WebAPI, complete: @escaping (JSON)->Void, failure: @escaping (String)->Void) {
        request(target, complete: { (value) in
            guard let _ = value.dictionaryObject else{
                failure("请求数据失败")
                return
            }
            complete(value["data"])
        }) { (msg) in
            failure(msg)
        }
    }
    
    /// 请求对象数据
    static func requestModel<T: BaseMappable>(_ target:WebAPI, model: T.Type, complete: @escaping (T)->Void, failure: @escaping (String)->Void) {
        request(target, complete: { (value) in
            debugPrints("通用接口Json数据---\(value)")
            if let model = Mapper<T>().map(JSONObject: value.object) {
                complete(model)
            }else {
                failure("请求数据失败")
            }
        }) { (msg) in
            failure(msg)
        }
    }
    
    /// 请求数组对象数据
    static func requestModelArray<T: BaseMappable>(_ target: WebAPI, model: T.Type, complete: @escaping ([T])-> Void, failure: @escaping (String)->Void) {
        requestJSON(target, complete: { (value) in
            if let models =  Mapper<T>().mapArray(JSONObject: value.object) {
                complete(models)
            }else {
                failure("请求数据失败")
            }
        }) { (msg) in
            failure(msg)
        }
    }
    
    /// 请求数组对象数据
    static func requestModelArrayWithKey<T: BaseMappable>(_ target: WebAPI, model: T.Type, key: String, complete: @escaping ([T])-> Void, failure: @escaping (String)->Void) {
        requestJSON(target, complete: { (value) in
            if let models =  Mapper<T>().mapArray(JSONObject: value[key].object) {
                complete(models)
            }else {
                failure("请求数据失败")
            }
        }) { (msg) in
            failure(msg)
        }
    }
    
    ///请求String数据
    static func requestString(target:WebAPI, complete: @escaping (String)->Void, failure: @escaping (String)->Void) {
        provider.request(target) { (result) -> () in
            switch result{
            case let .success(response):
                do {
                    let str = try response.mapString()
                    complete(str)
                } catch {
                    failure("请求数据失败")
                }
            case let .failure(error):
                failure(error.errorDescription ?? "请求数据失败")
            }
        }
    }
    
}
