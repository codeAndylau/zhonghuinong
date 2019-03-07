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
    
    // MARK: User-用户接口
    /// 微信登录
    case wechatLogin(_ p: [String: Any])
    ///  手机登录
    case mobileLogin(_ p: [String: Any])
    /// 添加、修改收货地址
    case editAddress(_ p: [String: Any])
    /// 用户的地址详情
    case userAddressDetail(_ p: [String: Any])
    /// 用户的地址列表
    case userAddressList(_ p: [String: Any])
    /// 删除用户的收获地址
    case deleteUserAddress(_ p: [String: Any])
    
    // MARK: Farm-农场接口
    /// 私家农场
    case farmLand(_ p: [String: Any])
    /// 取得农场传感器的值
    case farmSensordata(_ p: [String: Any])
    /// 浇水开关， 默认30秒结束
    case farmWater(_ p: [String: Any])
    /// 施肥开关， 默认30秒结束
    case farmFertilize(_ p: [String: Any])
    /// 杀虫开关 默认30秒结束
    case farmKillbug(_ p: [String: Any])
    
    // MARK: Shop-商店接口
    /// 首页轮播图
    case homeBannerList(_ p: [String: Any])
    /// 商品分类列表
    case catagoryList(_ p: [String: Any])
    /// 商品分类对应商品的列表
    case goodsList(_ p: [String: Any])
    /// 商品详情页
    case goodsDetail(_ id: Int)
    
    
    
    case xxx(_ p: [String: Any])
}

extension WebAPI: TargetType, WebAPIType {
    
    var baseURL: URL {
        switch self {
        case .wechatLogin(_),.mobileLogin(_),
             .farmLand(_),.farmWater(_),.farmKillbug(_),.farmFertilize(_):
            return Configs.Network.debugUrl
        default:
            return URL(string: "https://api.smartfarm.villagetechnology.cn")!
        }
    }
    
    var path: String {
        switch self {
            
        case .editAddress(_): return "/api/User/EditAddressV2"
        case .userAddressDetail(_): return "/api/User/UserAddressDetailV2"
        case .userAddressList(_): return "/api/User/UserAddressListV2"
        case .deleteUserAddress(_): return "/api/User/DeleteUserAddress"
            
        case .wechatLogin(_): return "/api/User/wechatapp"
        case .mobileLogin(_): return "/api/User/mobile"
            
        case .farmLand(_): return "/api/Farm/land"
        case .farmSensordata(_): return "/api/Farm/sensordata"
        case .farmWater(_): return "/api/Farm/water"
        case .farmFertilize(_): return "/api/Farm/fertilize"
        case .farmKillbug(_): return "/api/Farm/killbug"
            
        case .homeBannerList(_): return "/api/Shop/IndexBannerList"
        case .catagoryList(_): return "/api/Shop/CatagoryList"
        case .goodsList(_): return "/api/Shop/GoodsList"
        case .goodsDetail(let id): return "/api/Shop/GoodsDetail/\(id)"
            
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .wechatLogin(_), .mobileLogin(_), .farmWater(_), .farmFertilize(_), .farmKillbug(_):
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
        case .editAddress(let p),
             .userAddressDetail(let p),
             .userAddressList(let p),
             .deleteUserAddress(let p),
             .mobileLogin(let p),
             .farmLand(let p),
             .farmSensordata(let p),
             .farmWater(let p),
             .farmFertilize(let p),
             .farmKillbug(let p),
             .homeBannerList(let p),
             .catagoryList(let p),
             .goodsList(let p):
            return .requestParameters(parameters: p, encoding: URLEncoding.default) // 拼接在url中
        case .goodsDetail(_):
            let p: [String: Any] = ["wid": 5, "fromplat": "iOS"]
            return .requestParameters(parameters: p, encoding: URLEncoding.default) 
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["content-type" : "application/json; charset=utf-8"]
    }
    
    var addXAuth: Bool {
        switch self {
        default: return true
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
    
    /// 请求text接口
    static func requestText(_ target: WebAPI, complete: @escaping (JSON) ->Void, failure: @escaping (String) ->Void) {
        provider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    debugPrints("通用接口数据---\(response)")
                }catch let error {
                    failure(error.localizedDescription) // 服务器连接成功，但数据返回错误（同时会返回错误信息）
                }
            case let .failure(error):
                failure(error.localizedDescription) // 服务器连接不上，网络异常等（同时会返回错误信息。必要的话，还可以在此增加自动重新请求的机制。）
            }
        }
    }
    
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
                failure(Configs.Constant.errorInfo)
                return
            }
            complete(value["data"])
        }) { (msg) in
            failure(msg)
        }
    }
    
    /// 请求对象数据
    static func requestModel<T: BaseMappable>(_ target:WebAPI, model: T.Type, complete: @escaping (T)->Void, failure: @escaping (String)->Void) {
        requestJSON(target, complete: { (value) in
            if let model = Mapper<T>().map(JSONObject: value.object) {
                complete(model)
            }else {
                failure(Configs.Constant.errorInfo)
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
                failure(Configs.Constant.errorInfo)
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
                failure(Configs.Constant.errorInfo)
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
                    failure(Configs.Constant.errorInfo)
                }
            case let .failure(error):
                failure(error.errorDescription ?? "请求数据失败")
            }
        }
    }
    
}
