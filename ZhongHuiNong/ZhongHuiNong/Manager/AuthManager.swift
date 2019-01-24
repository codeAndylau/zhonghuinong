//
//  AuthManager.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import RxSwift

class AuthManager {
    
    static let shared = AuthManager()
    
    let tokenChanged = PublishSubject<String>()
    
    var token: String {
        get {
            let token = Defaults.shared.get(for: DefaultsKey.tokenKey)
            return token ?? ""
        }
        set {
            Defaults.shared.set(token, for: DefaultsKey.tokenKey)
            tokenChanged.onNext(newValue)
        }
    }
    
    var hasToken: Bool {
        if token.isEmpty || token == "" {
            return false
        }
        return true
    }
    
    class func setToken(token: String) {
        AuthManager.shared.token = token
    }
    
    class func removeToken() {
        Defaults.shared.clear(DefaultsKey.tokenKey)
    }
    
}

