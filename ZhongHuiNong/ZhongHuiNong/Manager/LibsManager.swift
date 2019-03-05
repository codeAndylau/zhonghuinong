//
//  LibsManager.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation

class LibsManager: NSObject {
    
    static let shared = LibsManager()
    
    func setupLibs() {
        
        // 1. 微信SDK
        WXApi.registerApp(Configs.Identifier.WeChat_AppId)
        
        // 2. 视频播放
        setupEZOpen()
        
    }
    
    func setupEZOpen() {
        // a. 判断是否有token
        // b. 有，是否过期
        // c. 没有，请求在保存
        // d. 最后在初始化视频播放sdk
        if let info = Defaults.shared.get(for: DefaultsKey.EZ_AccessToken) {
            let nowTime = Date()
            let expireTime = Date(timeIntervalSince1970: info.expireTime/1000)
            debugPrints("已经请求过token了--\(nowTime)---\(expireTime)")
            // 即表示没有过期，反之就过期了
            if nowTime.compare(expireTime) == ComparisonResult.orderedAscending {
                debugPrints("没有过期")
                EZUIKit.setDebug(false)
                EZUIKit.initWithAppKey(Configs.Identifier.EZ_AppKey)
                EZUIKit.setAccessToken(info.accessToken)
            }else {
                debugPrints("已经请求过token了")
                EZNetworkTool.shared.requestToken(completion: { (model) in
                    Defaults.shared.set(model, for: DefaultsKey.EZ_AccessToken)
                    EZUIKit.setDebug(false)
                    EZUIKit.initWithAppKey(Configs.Identifier.EZ_AppKey)
                    EZUIKit.setAccessToken(model.accessToken)
                }) { (error) in
                    debugPrints("请求视频播放的token错误---\(error)")
                    EZUIKit.initWithAppKey(Configs.Identifier.EZ_AppKey)
                    EZUIKit.setAccessToken(Configs.Identifier.EZ_AccessToken)
                }
            }
        }else {
            debugPrints("没有请求过")
            EZNetworkTool.shared.requestToken(completion: { (model) in
                Defaults.shared.set(model, for: DefaultsKey.EZ_AccessToken)
                EZUIKit.setDebug(false)
                EZUIKit.initWithAppKey(Configs.Identifier.EZ_AppKey)
                EZUIKit.setAccessToken(model.accessToken)
            }) { (error) in
                debugPrints("请求视频播放的token错误---\(error)")
                EZUIKit.initWithAppKey(Configs.Identifier.EZ_AppKey)
                EZUIKit.setAccessToken(Configs.Identifier.EZ_AccessToken)
            }
        }
    }
    
}
