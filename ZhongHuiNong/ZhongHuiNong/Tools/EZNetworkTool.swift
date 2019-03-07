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
    
    func requestAddress() {
        let url = "https://api.smartfarm.villagetechnology.cn/api/User/EditAddressV2"
        
        var params = [String: Any]()
        params["user_id"] = 3261  //"\(User.currentUser().userId)"
        params["linkMan"] = "兰超"
        params["preaddress"] = "四川省-面光源市-青羊区"
        params["address"] = "一栋一单元"
        params["mobile"] = "18782967728"
        params["youbian"] = "000000"
        params["isdefault"] = "true"
        params["address_id"] = 0
        params["wid"] = 5
        params["fromplat"] = "iOS"
        
        let header = ["content-type" : "application/json; charset=utf-8"]
        
        let request = Alamofire.request(url, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.default, headers: header)
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
    
}
