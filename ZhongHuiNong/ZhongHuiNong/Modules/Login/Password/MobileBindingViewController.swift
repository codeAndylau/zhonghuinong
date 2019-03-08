//
//  MobileBindingViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/8.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MobileBindingViewController: ViewController {
    
    var msgid = ""
    
    override func makeUI() {
        super.makeUI()
        navigationItem.title = localized("绑定手机号")
        view.addSubview(tableView)
        view.addSubview(bottomView)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        headerView.codeBtn.rx.tap.subscribe(onNext: { (_) in
            self.sendCode()
        }).disposed(by: rx.disposeBag)
        
        bottomView.sureBtn.rx.tap.subscribe(onNext: { (_) in
            self.sureBindingPhone()
        }).disposed(by: rx.disposeBag)
        
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe { [weak self] (_) in
            self?.view.endEditing(true)
            }.disposed(by: rx.disposeBag)
        view.addGestureRecognizer(tap)
        
    }
    
    // MARK: - Lazy
    lazy var headerView = MobileBindingView.loadView()
    let footerView = MobileBindingView.loadView().then { (view) in
        view.codeBtn.isHidden = true
        view.titleLab.text = "验证码"
        view.phoneTF.placeholder = "输入验证码"
    }
    
    lazy var bottomView = MineAddressBottomView.loadView().then { (view) in
        view.sureBtn.setTitle("确定", for: .normal)
    }
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH-kBottomViewH), style: .plain)
        view.backgroundColor = UIColor.white
        view.separatorStyle = .none
        view.tableHeaderView = headerView
        view.tableFooterView = footerView
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    // MARK: - Action
    
    func sendCode() {
        
        guard headerView.phoneTF.text != "" else {
            ZYToast.showCenterWithText(text: "请输入手机号")
            return
        }
        
        guard isPhone(mobile: headerView.phoneTF.text!) else {
            ZYToast.showCenterWithText(text: "请输入正确手机号")
            return
        }
        
        var params = [String: Any]()
        params["phonenumber"] = headerView.phoneTF.text!
       
        HudHelper.showWaittingHUD(msg: "发送中...")
        WebAPITool.request(WebAPI.sendCode(params), complete: { (value) in
            debugPrints("发送验证码---\(value)")
            HudHelper.hideHUD()
            self.msgid = value.stringValue
            DispatchTimer(timeInterval: 1, repeatCount: 60) { (timer, count) in
                self.headerView.codeBtn.setTitle("剩下\(count)s", for: .normal)
                self.headerView.codeBtn.isEnabled = false
                if count <= 0 {
                    self.headerView.codeBtn.isEnabled = true
                    self.headerView.codeBtn.setTitle("获取验证码", for: .normal)
                }
            }
        }) { (error) in
            HudHelper.hideHUD()
            ZYToast.showCenterWithText(text: "验证码发送失败,请稍后再试")
        }
        
    }
    
    func sureBindingPhone() {
        
        var params = [String: Any]()
        params["msgid"] = msgid
        params["userid"] = User.currentUser().userId
        params["code"] = footerView.phoneTF.text!
        params["phonenumber"] = headerView.phoneTF.text!
        
        debugPrints("手机绑定参数---\(params)")

        HudHelper.showWaittingHUD(msg: "请稍后...")
        WebAPITool.request(WebAPI.verifyCode(params), complete: { (value) in
            debugPrints("手机绑定---\(value)")
            HudHelper.hideHUD()
        }) { (error) in
            HudHelper.hideHUD()
            debugPrints("手机绑定出错---\(error)")
        }

//        // http://212.64.91.248:80//api/User/verifycode?code=128228&msgid=711589953672&phonenumber=18782967728&userid=3266
//        let url = "http://212.64.91.248/api/User/verifycode"
//        EZNetworkTool.shared.requestAddress(url, params: params)
//
        
        
    }

}
