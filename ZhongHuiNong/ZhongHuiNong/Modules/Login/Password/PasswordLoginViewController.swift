//
//  PasswordLoginViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import RxSwift

class PasswordLoginViewController: ViewController {

    let window = Application.shared.window!
    
    override func makeUI() {
        super.makeUI()
        view.addSubview(loginView)
        
        loginView.wechatBtn.isHidden = true
        
        if !WXApi.isWXAppInstalled() || isIPad() {
            loginView.wechatBtn.isHidden = true
        }
    }

    override func bindViewModel() {
        super.bindViewModel()
        navigationBarHidden.accept(true)
        loginView.psdBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.psdLoginAction()
        }).disposed(by: rx.disposeBag)
    }
    
    
    // MARK: - Lazy
    
    lazy var loginView = PasswordLoginView.loadView()
    
    func psdLoginAction() {
        
        self.view.endEditing(true)
        
        let phone = loginView.phoneTF.text!
        let code = loginView.codeTF.text!
        
        guard !phone.isEmpty else {
            let noticeBar = NoticeBar(title: "请输入手机号", defaultType: NoticeBarDefaultType.info)
            noticeBar.show(duration: 1.5, completed: nil)
            return
        }
        
        guard !code.isEmpty else {
            let config = NoticeBarConfig(title: "请输入验证码", barStyle: NoticeBarStyle.onNavigationBar)
            let noticeBar = NoticeBar(config: config)
            noticeBar.show(duration: 1.5, completed: nil)
            return
        }
        
        guard phone == "18782967728" else {
            ZYToast.showTopWithText(text: "手机号不正确!")
            return
        }
        
        guard code == "1234" else {
            ZYToast.showTopWithText(text: "验证码不正确!")
            return
        }
        
        HudHelper.showWaittingHUD(msg: "登录中...")
        delay(by: 1.5) {
            HudHelper.hideHUD()
            mainQueue {
                self.navigator.show(segue: .tabs, sender: nil, transition: .root(window: self.window))   // 登录了直接进入首页
            }
        }
        
        
//        var p = [String: Any]()
//        p["phonenumber"] = phone
//
//        WebAPITool.request(WebAPI.mobileLogin(p), complete: { (value) in
//            debugPrints("手机登录---\(value)")
//        }) { (error) in
//            debugPrints("手机登录失败---\(error)")
//        }

    }
}
