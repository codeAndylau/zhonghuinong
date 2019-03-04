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
        
    }
    
}
