//
//  WechatLoginViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import MBProgressHUD

class WechatLoginViewController: ViewController {

    override func makeUI() {
        super.makeUI()
        view.addSubview(loginView)
        
        //        if !WXApi.isWXAppInstalled() || isIPad() {
        //            loginView.wechatBtn.isHidden = true
        //        }
    }

    override func bindViewModel() {
        super.bindViewModel()
        
        navigationBarHidden.accept(true)
        loginView.wechatBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.wechatLoginAction()
        }).disposed(by: rx.disposeBag)
        
        loginView.otherBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.navigator.show(segue: .psdLogin, sender: self, transition: .navigation)
        }).disposed(by: rx.disposeBag)
        
        NotificationCenter.default.rx.notification(Notification.Name.wechatLoginNotification).subscribe(onNext: { [weak self] (notification) in
            guard let self = self else { return }
            let code = notification.userInfo?["code"] as! String
            debugPrints("微信授权回调的code---\(code)")
            self.wechatLogin(code: code)
        }).disposed(by: rx.disposeBag)
        
    }
    
    
    // MARK: - Lazy
    lazy var loginView = WechatLoginView.loadView()
    
    // MARK: - Action
    
    func wechatLoginAction() {
        
        //        let req = SendAuthReq()
        //        req.scope = "snsapi_userinfo"
        //        req.state = Configs.Identifier.WeChat_AppId
        //
        //        if WXApi.isWXAppInstalled() {
        //            WXApi.send(req)
        //        }else {
        //            WXApi.sendAuthReq(req, viewController: self, delegate: self)
        //        }
        //        
        //        let noticeBar = NoticeBar(title: "微信登录中...", defaultType: .info)
        //        noticeBar.show(duration: 1.5) { (finished) in
        //            if finished {
        //                self.navigator.show(segue: .psdLogin, sender: self, transition: .navigation)
        //            }
        //        }
        
        self.navigator.show(segue: .psdLogin, sender: self, transition: .navigation)
    }
    
    func wechatLogin(code: String) {
        
    }
    
}

extension WechatLoginViewController: WXApiDelegate {
    
    func onResp(_ resp: BaseResp) {
        debugPrints("登录页面的微信回调---\(resp.errCode)")
        if resp.isKind(of: SendAuthResp.self) {
            let auth = resp as! SendAuthResp
            let code = auth.code!
            switch resp.errCode {
            case 0:
                NotificationCenter.default.post(name: .wechatLoginNotification, object: nil, userInfo: ["code": code])
            case -4:
                MBProgressHUD.showInfo("用户拒绝授权")
            case -2:
                MBProgressHUD.showInfo("用户取消授权")
            default:
                MBProgressHUD.showInfo("用户授权失败")
            }
        }
    }
}
