//
//  EZNetworkTool.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/5.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class EZNetworkTool {
    
    static let shared: EZNetworkTool = EZNetworkTool()
    
    ///  查询视频播放的token
    func requestToken(completion: @escaping (EZAccessToken) ->Void, failure: @escaping (String) ->Void) {
        
        let ez_url = "https://open.ys7.com/api/lapp/token/get"
        let params: [String: Any] = ["appKey": "ceb7361666b144d7985afbb1e1ceafaf", "appSecret": "f82e443d6a2d3304a311e10528578388"]
        
        Alamofire.request(ez_url, method: HTTPMethod.post, parameters: params).responseJSON { (response) in
            guard let result = response.result.value else {
                failure(String(describing: response.result.error))
                return
            }
            // 直接解析
            let dict = JSON(result)
            let code = dict["code"].intValue
            let msge = dict["msg"].stringValue
            
            debugPrints("视频监控的token---\(dict)")
            
            if code == 200 {
                let a = dict["data"]["accessToken"].stringValue
                let e = dict["data"]["expireTime"].doubleValue
                let model = EZAccessToken(a: a, e: e)
                completion(model)
            }else {
                failure(msge)
            }
        }
    }
    
    /// 请求地址 
    func requestAddress(_ url: String, params: [String: Any]) {
        let request = Alamofire.request(url, method: HTTPMethod.post, parameters: nil, encoding: URLEncoding.default)
        debugPrints("请求的data--\(request)")
        request.responseJSON { (response) in
            guard let result = response.result.value else {
                debugPrints("fuck失败---\(String(describing: response.result.error))")
                return
            }
            // 直接解析
            let dict = JSON(result)
            debugPrints("fuck---\(dict)")
        }
    }
    
    /// 删除订单
    func requestDeleteOrder(_ url: String, completion: @escaping (Bool) ->Void, failure: @escaping (String) ->Void) {
        let request = Alamofire.request(url, method: HTTPMethod.post, parameters: nil, encoding: URLEncoding.default)
        debugPrints("请求的data--\(request)")
        request.responseJSON { (response) in
            guard let result = response.result.value else {
                failure(String(describing: response.result.error))
                return
            }
            // 直接解析
            let dict = JSON(result)
            debugPrints("删除订单---\(dict)")
            let status = dict["status"].intValue
            let detail = dict["detail"].stringValue
            
            if status == 1 {
                completion(true)
            }else {
                failure(detail)
            }
        }
    }
    
    
    /// 绑定手机
    func requestBindPhone(_ url: String,completion: @escaping (Bool) ->Void, failure: @escaping (String) ->Void) {
        let request = Alamofire.request(url, method: HTTPMethod.post, parameters: nil, encoding: URLEncoding.default)
        debugPrints("请求的data--\(request)")
        request.responseJSON { (response) in
            guard let result = response.result.value else {
                failure(String(describing: response.result.error))
                return
            }
            // 直接解析
            let dict = JSON(result)
            debugPrints("手机绑定---\(dict)")
            completion(dict.boolValue)    
        }
    }
    
    /// 物流查询
    func aliwuliuQuery(order: String, completion: @escaping (KuaidiInfo) ->Void, failure: @escaping (String) ->Void) {
        
        let url = "http://kdwlcxf.market.alicloudapi.com/kdwlcx?no=\(order)&type=auto"
        let header = ["Authorization": "APPCODE 8ac99a4ed9a94e24826e8467623a4adb",
                      "Content-Type": "application/json; charset=UTF-8"]
        
        Alamofire.request(url, method: HTTPMethod.get, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            guard let value = response.result.value else {
                debugPrints("物流查询失败---\(String(describing: response.result.error))")
                return
            }
            
            // 直接解析
            let dict = JSON(value)
            debugPrints("物流查询---\(dict)")
            let status = dict["status"].intValue
            let msg = dict["msg"].stringValue
            let result = dict["result"].object
            if status == 0 {
                if let model = Mapper<KuaidiInfo>().map(JSONObject: result) {
                    completion(model)
                }else {
                    failure(msg)
                }
            }else {
                failure(msg)
            }
        }
    }
    
}
