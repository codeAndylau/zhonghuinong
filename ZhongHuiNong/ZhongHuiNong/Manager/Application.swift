//
//  Application.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

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
            
            
            
        }).disposed(by: rx.disposeBag)
        
    }
    
    
    func presentInitialScreen(in window: UIWindow) {
        self.window = window
        //let loginIn = authManager.hasToken
        navigator.show(segue: .tabs, sender: nil, transition: .root(window: window))
    }
    
    func showRootWindow(in window: UIWindow?) {
        self.window = window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.black
        self.window?.rootViewController = UINavigationController(rootViewController: HomeViewController()) 
        self.window?.makeKeyAndVisible()
    }

}
