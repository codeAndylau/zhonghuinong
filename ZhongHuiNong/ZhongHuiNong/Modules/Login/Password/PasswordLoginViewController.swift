//
//  PasswordLoginViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class PasswordLoginViewController: ViewController {

    override func makeUI() {
        super.makeUI()
        view.addSubview(loginView)
    }
    
    override func updateUI() {
        super.updateUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        navigationBarHidden.accept(true)
        
        let window = Application.shared.window!
        loginView.psdBtn.rx.tap.subscribe(onNext: { (_) in
            self.navigator.show(segue: .tabs, sender: nil, transition: .root(window: window))   // 登录了直接进入首页
        }).disposed(by: rx.disposeBag)
    }
    
    
    // MARK: - Lazy
    
    lazy var loginView = PasswordLoginView.loadView()
    
}
