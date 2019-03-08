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
    
    func requestAddress(_ url: String, params: [String: Any]) {
        
        let request = Alamofire.request(url, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.default)
        debugPrints("请求的data--\(request)")
        
//        http://212.64.91.248   /api/User/verifycode?msgid=711586707391&code=567508&userid=3266&phonenumber=18782967728
//        http://212.64.91.248:80/api/User/verifycode?code=567508&msgid=711586707391&phonenumber=18782967728&userid=3266
//        
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
