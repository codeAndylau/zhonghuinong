//
//  WechatLoginViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class WechatLoginViewController: ViewController {

    override func makeUI() {
        super.makeUI()
        view.addSubview(loginView)
    }

    override func updateUI() {
        super.updateUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        //statusBarStyle.accept(true)
        navigationBarHidden.accept(true)
        
        loginView.wechatBtn.rx.tap.subscribe(onNext: { (_) in
            self.navigator.show(segue: .psdLogin, sender: self, transition: .navigation)
        }).disposed(by: rx.disposeBag)
    }
    
    
    // MARK: - Lazy
    
    lazy var loginView = WechatLoginView.loadView()
    
}
