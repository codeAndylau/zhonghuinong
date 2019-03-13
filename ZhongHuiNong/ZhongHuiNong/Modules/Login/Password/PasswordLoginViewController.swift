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
    
    var msgid = ""
    
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
        
        loginView.codeBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.sendCode()
        }).disposed(by: rx.disposeBag)
        
        loginView.psdBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.psdLoginAction()
        }).disposed(by: rx.disposeBag)
    }
    
    
    // MARK: - Lazy
    
    lazy var loginView = PasswordLoginView.loadView()
    
    func sendCode() {
        
        guard loginView.phoneTF.text != "" else {
            ZYToast.showTopWithText(text: "请输入手机号")
            return
        }
        
        guard isPhone(mobile: loginView.phoneTF.text!) else {
            ZYToast.showTopWithText(text: "请输入正确手机号")
            return
        }
        
        var params = [String: Any]()
        params["phonenumber"] = loginView.phoneTF.text!
        
        WebAPITool.request(WebAPI.sendCode(params), complete: { (value) in
            debugPrints("发送验证码---\(value)")
            
            ZYToast.showTopWithText(text: "已发送")
            
            self.msgid = value.stringValue
            DispatchTimer(timeInterval: 1, repeatCount: 60) { (timer, count) in
                self.loginView.codeBtn.setTitle("剩下\(count)s", for: .normal)
                self.loginView.codeBtn.isEnabled = false
                if count <= 0 {
                    self.loginView.codeBtn.isEnabled = true
                    self.loginView.codeBtn.setTitle("获取验证码", for: .normal)
                }
            }
        }) { (error) in
            ZYToast.showTopWithText(text: "验证码发送失败,请稍后再试")
        }
        
    }
    
    func psdLoginAction() {
        
        self.view.endEditing(true)
        
        let phone = loginView.phoneTF.text!
        let code = loginView.codeTF.text!
        
        guard !phone.isEmpty else {
            showNoticebar(text: "请输入手机号")
            return
        }
        
        guard !code.isEmpty else {
            showNoticebar(text: "请输入验证码")
            return
        }
        
        guard isPhone(mobile: phone) else {
            showNoticebar(text: "手机号有误")
            return
        }
        
        if phone == developmentMan {
            msgid = "123456"
        }
        
        var parmas = [String: Any]()
        parmas["msgid"] = msgid
        parmas["code"] =  code
        parmas["phonenumber"] = phone
        
        debugPrints("手机登录的参数---\(parmas)") // 13568915921
        
        HudHelper.showWaittingHUD(msg: "登录中...")
        WebAPITool.requestModel(WebAPI.mobileLogin(parmas), model: User.self, complete: { (user) in
            HudHelper.hideHUD()
            user.save()
            mainQueue {
                self.navigator.show(segue: .tabs, sender: nil, transition: .root(window: self.window))   // 登录了直接进入首页
            }
        }) { (error) in
            HudHelper.hideHUD()
            ZYToast.showCenterWithText(text: "登录失败!")
        }
        
//        HudHelper.showWaittingHUD(msg: "登录中...")
//        delay(by: 1.5) {
//            HudHelper.hideHUD()
//            mainQueue {
//                self.navigator.show(segue: .tabs, sender: nil, transition: .root(window: self.window))   // 登录了直接进入首页
//            }
//        }
        
//        HudHelper.showWaittingHUD(msg: "登录中...")
//        WebAPITool.request(WebAPI.mobileLogin(parmas), complete: { (value) in
//            debugPrints("手机登录---\(value)")
//        }) { (error) in
//            debugPrints("手机登录失败---\(error)")
//        }
        
        
//        HudHelper.showWaittingHUD(msg: "登录中...")
//        WebAPITool.requestModel(WebAPI.wechatLogin(parameters), model: User.self, complete: { (user) in
//            HudHelper.hideHUD()
//            user.save()
//            mainQueue {
//                self.navigator.show(segue: .tabs, sender: nil, transition: .root(window: self.window))   // 登录了直接进入首页
//            }
//        }) { (error) in
//            HudHelper.hideHUD()
//            ZYToast.showCenterWithText(text: "登录失败!")
//        }
    }
}
