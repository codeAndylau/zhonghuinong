//
//  WechatLoginViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON
import ObjectMapper

class WechatLoginViewController: ViewController {
    
    let window = Application.shared.window!
    
    override func makeUI() {
        super.makeUI()
        view.addSubview(loginView)
        if !WXApi.isWXAppInstalled() || isIPad() {
            loginView.wechatBtn.isHidden = true
        }
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
            self.fetchAccessTokenWith(code)
        }).disposed(by: rx.disposeBag)
        
    }
    
    
    // MARK: - Lazy
    lazy var loginView = WechatLoginView.loadView()
    
    // MARK: - Action
    
    // 1. 请求微信登录收取获取code
    func wechatLoginAction() {
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = Configs.Identifier.WeChat_AppId
        if WXApi.isWXAppInstalled() {
            WXApi.send(req)
        }else {
            WXApi.sendAuthReq(req, viewController: self, delegate: self)
        }
    }
    
    // 2.通过code获取access_token
    func fetchAccessTokenWith(_ code: String) {
        
        let url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(Configs.Identifier.WeChat_AppId)&secret=\(Configs.Identifier.weChat_Secret)&code=\(code)&grant_type=authorization_code"
        
        Alamofire.request(url).responseJSON { (response) in
            switch response.result.value {
            case .none:
                debugPrints("请求返回失败---\(response.result.error!)")
            case .some(let value):
                let dict = JSON(value)
                let access_token = dict["access_token"].stringValue
                let openid = dict["openid"].stringValue
                
                self.fetchUserInfoWith(access_token, openid: openid)
                
                /*
                 {
                 "access_token":"ACCESS_TOKEN",             接口调用凭证
                 "expires_in":7200,                         access_token接口调用凭证超时时间，单位（秒）
                 "refresh_token":"REFRESH_TOKEN",           用户刷新access_token
                 "openid":"OPENID",                         授权用户唯一标识
                 "scope":"SCOPE",                           用户授权的作用域，使用逗号（,）分隔
                 "unionid":"o6_bmasdasdsad6_2sgVt7hMZOPfL"  当且仅当该移动应用已获得该用户的userinfo授权时，才会出现该字段
                 }
                 */                
            }
        }
        
    }
    
    // 3.通过access_token调用接口
    func fetchUserInfoWith(_ token: String, openid: String) {
        
        let url = "https://api.weixin.qq.com/sns/userinfo?access_token=\(token)&openid=\(openid)"
        
        Alamofire.request(url).responseJSON { (response) in
            switch response.result.value {
            case .none:
                debugPrints("请求微信用户信息返回失败---\(response.result.error!)")
            case .some(let value):
                let dict = JSON(value)
                var parameters = [String: Any]()
                parameters["unionid"] = dict["unionid"].stringValue
                parameters["openid"] = dict["openid"].stringValue
                parameters["nickname"] = dict["nickname"].stringValue
                parameters["sex"] = dict["sex"].stringValue
                parameters["city"] = dict["city"].stringValue
                parameters["country"] = dict["country"].stringValue
                parameters["province"] = dict["province"].stringValue
                parameters["headimgurl"] = dict["headimgurl"].stringValue
                
                self.wechatLogin(parameters)
                
                // http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIKIXoZ6dm9vqQ6MVZAwTMS4gk8IVAQT0QH9JJv5fOwDkHxVPmzMiaT0ViaGXFibNfdQzrWypYYqM4lQ/132
                
                /*
                 {
                 openid    普通用户的标识，对当前开发者帐号唯一
                 nickname    普通用户昵称
                 sex    普通用户性别，1为男性，2为女性
                 province    普通用户个人资料填写的省份
                 city    普通用户个人资料填写的城市
                 country    国家，如中国为CN
                 headimgurl    用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空
                 privilege    用户特权信息，json数组，如微信沃卡用户为（chinaunicom）
                 unionid    用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的。
                 }
                 */
            }
        }
    }
    
    // 4. 通过获取微信用户信息后 请求微信登录
    func wechatLogin(_ parameters: [String: Any]) {
        
        HudHelper.showWaittingHUD(msg: "登录中...")
        WebAPITool.request(WebAPI.wechatLogin(parameters), complete: { (value) in
            if let user = Mapper<User>().map(JSONObject: value.object) {
                debugPrints("微信登录的user--\(user)")
                user.save()
                HudHelper.hideHUD(FromView: nil)
                mainQueue {
                    self.navigator.show(segue: .tabs, sender: nil, transition: .root(window: self.window))   // 登录了直接进入首页
                }
            }else {
                ZYToast.showCenterWithText(text: "登录失败!")
            }
        }) { (error) in
            ZYToast.showCenterWithText(text: "登录失败!")
        }
        
        /*
         let noticeBar = NoticeBar(title: "数据解析失败!", defaultType: .info)
         noticeBar.show(duration: 1.5, completed: nil)
         */
    }
    
}

extension WechatLoginViewController: WXApiDelegate {
    
    func onResp(_ resp: BaseResp) {
        if resp.isKind(of: SendAuthResp.self) {
            let auth = resp as! SendAuthResp
            switch resp.errCode {
            case 0:
                if let code = auth.code {
                    self.fetchAccessTokenWith(code)
                }
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
