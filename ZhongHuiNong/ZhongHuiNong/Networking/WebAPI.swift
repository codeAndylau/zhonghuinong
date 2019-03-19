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
    var addAuth: Bool { get }
    var addCache: Bool { get }
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
    /// 验证支付密码
    case validationPyaPassword(_ p: [String: Any])
    /// 设置支付密码
    case settingPayPassword(_ p: [String: Any])
    /// 用户的额度信息
    case userBalance(_ p: [String: Any])
    /// 发送验证码
    case sendCode(_ p: [String: Any])
    /// 验证手机
    case verifyCode(_ p: [String: Any])
    /// 绑定手机
    case bindMobile(_ p: [String: Any])
    /// 获取用户信息
    case fetchUserInfo(_ p: [String: Any])
    
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
    /// 首页热销商品
    case goodsHotsaleList(_ p: [String: Any])
    /// 首页爆款推荐
    case goodsRecommendList(_ p: [String: Any])
    
    // MARK: Order-订单接口
    /// 购物车创建订单
    case createOrder(_ p: [String: Any])
    /// 删除订单
    case deleteOrder(_ p: [String: Any])
    /// 添加商品到购物车
    case addToCart(_ userId: Int, _ p: [[String: Any]])
    /// 清空购物车
    case removeCart(_ body: [[String: Any]] , _ p: [String: Any])
    /// 获取购物车
    case fetchCart(_ p: [String: Any])
    /// 验证支付密码
    case validationPayPassword(_ p: [String: Any])
    /// 用余额支付
    case cartOrderPayment(_ p: [String: Any])
    
    /// 获取用户的订单列表
    case fetchUserOrderList(_ p: [String: Any])
    /// 商品订单详情
    case fetchUserOrderDetail(_ p: [String: Any])
    /// 确认收货
    case userOrderReceipt(_ p: [String: Any])
    /// 商品评价
    case userOrderReputation(_ p: [String: Any])
    /// 获取商品评价信息
    case userOrderReputationShow(_ p: [String: Any])
    /// 取消订单
    case cancelOrder(_ p: [String: Any])
    
    
    // MARK: - Dispatch 用户蔬菜配送
    
    /// 取得配送日期
    case fetchDispatchDate(_ p: [String: Any])
    /// 设置配送日期， 如果是第一次，则是添加
    case settingDispatchDate(_ userId: Int, _ p: [String: Any])
    /// 获取所有用户的配送菜单
    case fetchDispatchMenu
    /// 创建配送订单
    case createDispatchOrder(_ b: [[String: Any]], _ p: [String: Any])
    /// 配送订单列表 status 1 等于在正在进行中的订单， status 2 是历史订单
    case dispatchOrderList(_ p: [String: Any])
    /// 配送订单详情
    case dispatchOrderDetail(_ p: [String: Any])
    /// 配送快递列表
    case dispatchTrackingList(_ p: [String: Any])
    
    case xxx(_ p: [String: Any])
}

extension WebAPI: TargetType, WebAPIType {
    
    var baseURL: URL {
        switch self {
        case.wechatLogin(_),.mobileLogin(_), .settingPayPassword(_), .userBalance(_), .sendCode(_), .verifyCode(_), .bindMobile(_), .fetchUserInfo(_),
            .farmLand(_),.farmWater(_),.farmKillbug(_),.farmFertilize(_),
            .createOrder(_), .deleteOrder(_), .addToCart(_, _), .fetchCart(_), .removeCart(_, _), .cartOrderPayment(_), .validationPayPassword(_),
            .fetchDispatchDate(_), .settingDispatchDate(_,_), .fetchDispatchMenu, .createDispatchOrder(_,_), .dispatchOrderList(_), .dispatchOrderDetail(_), .dispatchTrackingList(_):
            
            return Configs.Network.debugUrl
        default:
            return URL(string: "https://api.smartfarm.villagetechnology.cn")!
        }
    }
    
    var path: String {
        
        switch self {
            
        case .bindMobile(_): return "/api/User/bindmobile"
        case .verifyCode(_): return "/api/User/verifycode"
        case .sendCode(_): return "/api/User/sendcode"
        case .userBalance(_): return "/api/User/userbalance"
        case .validationPyaPassword(_): return "/api/User/paymentpassword"
        case .settingPayPassword(_): return "/api/User/paymentpassword"
        case .wechatLogin(_): return "/api/User/wechatapp"
        case .mobileLogin(_): return "/api/User/mobile"
        case .fetchUserInfo(_): return "/api/User/userinfo"
            
        case .editAddress(_): return "/api/User/EditAddressV2"
        case .userAddressDetail(_): return "/api/User/UserAddressDetailV2"
        case .userAddressList(_): return "/api/User/UserAddressListV2"
        case .deleteUserAddress(_): return "/api/User/DeleteUserAddress"
            
        case .farmLand(_): return "/api/Farm/land"
        case .farmSensordata(_): return "/api/Farm/sensordata"
        case .farmWater(_): return "/api/Farm/water"
        case .farmFertilize(_): return "/api/Farm/fertilize"
        case .farmKillbug(_): return "/api/Farm/killbug"
            
        case .homeBannerList(_): return "/api/Shop/IndexBannerList"
        case .catagoryList(_): return "/api/Shop/CatagoryList"
        case .goodsList(_): return "/api/Shop/GoodsList"
        case .goodsDetail(let id): return "/api/Shop/GoodsDetail/\(id)"
        case .goodsHotsaleList(_): return "/api/Shop/GoodsListHotsale"
        case .goodsRecommendList(_): return "/api/Shop/GoodsListRecommend"
            
        case .createOrder(_): return "/api/Order/createorder"
        case .deleteOrder(_): return "/api/Order/deleteorder"
        case .addToCart(_, _): return "/api/Order/addtocart"
        case .removeCart(_, _): return "/api/Order/removecart"
        case .fetchCart(_): return "/api/Order/cart"
        case .validationPayPassword(_): return "/api/User/paymentpassword"
            
        case .cartOrderPayment(_): return "/api/Order/payment"
        case .fetchUserOrderList(_): return "/api/Order/UserOrderList"
        case .fetchUserOrderDetail(_): return "/api/Order/UserOrderDetail"
        case .userOrderReceipt: return "/api/Order/UserOrderReceipt"
        case .cancelOrder(_): return "/api/Order/CancelOrder"
            
        case .fetchDispatchDate(_): return "/api/Dispatch/dispatchdate"
        case .settingDispatchDate(_,_): return "/api/Dispatch/dispatchdate"
        case .fetchDispatchMenu: return "/api/Dispatch/dispatchmenu"
        case .createDispatchOrder(_,_): return "/api/Dispatch/createdispatchorder"
        case .dispatchOrderList(_): return "/api/Dispatch/dispatchorderlist"
        case .dispatchOrderDetail(_): return "/api/Dispatch/dispatchorderdetail"
        case .dispatchTrackingList(_): return "/api/Dispatch/dispatchtracking"
            
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .wechatLogin(_), .mobileLogin(_), .settingPayPassword(_), .verifyCode(_), .bindMobile(_),
             .farmWater(_), .farmFertilize(_), .farmKillbug(_),
             .createOrder(_), .addToCart(_, _), .removeCart(_,_), .cartOrderPayment(_),
             .settingDispatchDate(_,_), .createDispatchOrder(_,_), .deleteOrder(_):
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
            
        case .wechatLogin(let p), .createOrder(let p):
            return .requestData(dictToData(dict: p)) //参数放在HttpBody中
            
        case .removeCart(let b, let p):
            return .requestCompositeData(bodyData: arrayToData(array: b), urlParameters: p)
            
        case .addToCart(let id, let p):
            let params = ["userId": id]
            return .requestCompositeData(bodyData: arrayToData(array: p), urlParameters: params)
            
        case .settingDispatchDate(let id, let p):
            let params = ["userId": id]
            return .requestCompositeData(bodyData: dictToData(dict: p), urlParameters: params)
            
        case .createDispatchOrder(let b, let p): // 创建配送订单
            return .requestCompositeData(bodyData: arrayToData(array: b), urlParameters: p)
            
        case .sendCode(let p),
             .userBalance(let p),
             .settingPayPassword(let p),
             .validationPyaPassword(let p),
             .editAddress(let p),
             .userAddressDetail(let p),
             .userAddressList(let p),
             .deleteUserAddress(let p),
             
             .farmLand(let p),
             .farmSensordata(let p),
             .farmWater(let p),
             .farmFertilize(let p),
             .farmKillbug(let p),
             
             .homeBannerList(let p),
             .catagoryList(let p),
             .goodsList(let p),
             .goodsHotsaleList(let p),
             .goodsRecommendList(let p),
             
             .fetchCart(let p),
             .fetchUserOrderList(let p),
             .fetchUserOrderDetail(let p),
             .userOrderReceipt(let p),
             .userOrderReputation(let p),
             .userOrderReputationShow(let p),
             .cancelOrder(let p):
            
            return .requestParameters(parameters: p, encoding: URLEncoding.default)
            
        // 拼接在url中
        case .cartOrderPayment(let p), .validationPayPassword(let p), .verifyCode(let p), .bindMobile(let p),
             .dispatchOrderList(let p), .fetchUserInfo(let p), .mobileLogin(let p),
             .fetchDispatchDate(let p), .deleteOrder(let p):
            return .requestCompositeData(bodyData: Data(), urlParameters: p)
            
        case .goodsDetail(_):
            let p: [String: Any] = ["wid": 1, "fromplat": "iOS"]
            return .requestParameters(parameters: p, encoding: URLEncoding.default)
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        
        switch self {
            
        case .wechatLogin(_), .addToCart(_, _), .createOrder(_), .settingDispatchDate(_, _), .createDispatchOrder(_, _), .removeCart(_, _):
            return ["content-type" : "application/json-patch+json"]
        case .validationPayPassword(_), .deleteOrder(_):
            return ["content-type": "application/json; charset=utf-8"]
        default:
            return ["content-type": "text/plain; charset=utf-8"]
        }
        
    }
    
    var addAuth: Bool {
        switch self {
        default: return true
        }
    }
    
    var addCache: Bool {
        switch self {
        case .homeBannerList(_), .catagoryList(_), .goodsHotsaleList(_), .userBalance(_), .fetchUserInfo(_):
            return true
        default:
            return false
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
    
    /// 测试接口
    static func requestText(_ target: WebAPI, complete: @escaping (JSON) ->Void, failure: @escaping (String) ->Void) {
        let request = provider.request(target) { (result) in
            switch result {
            case let .success(response):
                debugPrints("text接口数据---\(response)")
            case let .failure(error):
                failure(error.localizedDescription) // 服务器连接不上，网络异常等（同时会返回错误信息。必要的话，还可以在此增加自动重新请求的机制。）
            }
        }
        debugPrints("测试接口的url---\(request)")
    }
    
    /// 请求通用接口
    static func request(_ target: WebAPI, complete: @escaping (JSON) ->Void, failure: @escaping (String) ->Void) {
        if target.addCache {
           let _ = provider.cacheRequest(target) { (result) in
                switch result {
                case let .success(response):
                    do {
                        let _ = try response.filterSuccessfulStatusCodes()
                        let value = try JSON(response.mapJSON())
                        debugPrints("缓存接口\(target.path)---\(target.path)---\(value)")
                        complete(value)
                    }catch let error {
                        failure(error.localizedDescription)
                    }
                case let .failure(error):
                    failure(error.localizedDescription)
                }
            }
        }else {
            provider.request(target) { (result) in
                switch result {
                case let .success(response):
                    do {
                        let _ = try response.filterSuccessfulStatusCodes() // 只返回200-299的成功状态吗
                        let value = try JSON(response.mapJSON())
                        debugPrints("通用接口数据---\(target.path)---\(value)")
                        complete(value)
                    }catch let error {
                        failure(error.localizedDescription) // 服务器连接成功，但数据返回错误（同时会返回错误信息）
                    }
                case let .failure(error):
                    failure(error.localizedDescription) // 服务器连接不上，网络异常等（同时会返回错误信息。必要的话，还可以在此增加自动重新请求的机制。）
                }
            }
        } 
    }
    
    /// 请求对象数据
    static func requestModel<T: BaseMappable>(_ target:WebAPI, model: T.Type, complete: @escaping (T)->Void, failure: @escaping (String)->Void) {
        request(target, complete: { (value) in
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
        request(target, complete: { (value) in
            if let models =  Mapper<T>().mapArray(JSONObject: value.object) {
                complete(models)
            }else {
                failure(Configs.Constant.errorInfo)
            }
        }) { (msg) in
            failure(msg)
        }
    }
    
    /// 请求数据WithData
    static func requestData(_ target: WebAPI, complete: @escaping (JSON)->Void, failure: @escaping (String)->Void) {
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
    
    /// 请求对象数据WithData
    static func requestModelWithData<T: BaseMappable>(_ target:WebAPI, model: T.Type, complete: @escaping (T)->Void, failure: @escaping (String)->Void) {
        requestData(target, complete: { (value) in
            if let model = Mapper<T>().map(JSONObject: value.object) {
                complete(model)
            }else {
                failure(Configs.Constant.errorInfo)
            }
        }) { (msg) in
            failure(msg)
        }
    }
    
    /// 请求数组对象数据WithData
    static func requestModelArrayWithData<T: BaseMappable>(_ target: WebAPI, model: T.Type, complete: @escaping ([T])-> Void, failure: @escaping (String)->Void) {
        requestData(target, complete: { (value) in
            if let models =  Mapper<T>().mapArray(JSONObject: value.object) {
                complete(models)
            }else {
                failure(Configs.Constant.errorInfo)
            }
        }) { (msg) in
            failure(msg)
        }
    }
    
    /// 请求对象数据WithKey
    static func requestModelWithKey<T: BaseMappable>(_ target: WebAPI, model: T.Type, key: String, complete: @escaping (T)-> Void, failure: @escaping (String)->Void) {
        requestData(target, complete: { (value) in
            if let model =  Mapper<T>().map(JSONObject: value[key].object) {
                complete(model)
            }else {
                failure(Configs.Constant.errorInfo)
            }
        }) { (msg) in
            failure(msg)
        }
    }
    
    /// 请求数组对象数据
    static func requestModelArrayWithKey<T: BaseMappable>(_ target: WebAPI, model: T.Type, key: String, complete: @escaping ([T])-> Void, failure: @escaping (String)->Void) {
        requestData(target, complete: { (value) in
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
