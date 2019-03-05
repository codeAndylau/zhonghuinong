//
//  Application.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let globalStatusBarStyle = BehaviorRelay<UIStatusBarStyle>(value: .default)

class Application: NSObject {
    
    static let shared = Application()
    
    var window: UIWindow?
    
    let navigator: Navigator
    let provider: NetworkTool
    let authManager: AuthManager
    
    override init() {
        navigator = Navigator.shared
        provider = NetworkTool.shared
        authManager = AuthManager.shared
        super.init()
        authManager.tokenChanged.subscribe(onNext: { (token) in
            debugPrints("用户token过期")
        }).disposed(by: rx.disposeBag)
    }
    
    func presentInitialScreen(in window: UIWindow) {
        self.window = window
        let loginIn = User.hasUserId() /// 判断当前用户是否登录过
        if loginIn {
            navigator.show(segue: .tabs, sender: nil, transition: .root(window: window))   // 登录了直接进入首页
        }else {
            navigator.show(segue: .login, sender: nil, transition: .root(window: window))  // 没有登录就直接进入登录页面
        }
    }

}

