//
//  PayPasswordViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 支付密码框的试图控制器
class PayPasswordViewController: SwiftPopup {

    var order_no = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(paySureView)
        
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe(onNext: { [weak self] (gesture) in
            guard let self = self else { return }
            if !self.paySureView.frame.contains(gesture.location(in: self.view)) {
                self.dismiss()
            }
        }).disposed(by: rx.disposeBag)
        view.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer()
        tap1.rx.event.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.paySureView.boxView.tf.resignFirstResponder()
        }).disposed(by: rx.disposeBag)
        paySureView.addGestureRecognizer(tap1)
        
        paySureView.cancelBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        paySureView.boxView.entryCompleteBlock = { [weak self] (psd) in
            guard let self = self else { return }
            debugPrints("输入的密码是---\(psd)")
            self.validationPayPassword(psd)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        debugPrints("支付密码框界面已经销毁")
    }
    
    // MARK: - Lazy
    
    lazy var paySureView = PayPasswordView.loadView()


    
    // MARK: - Action
    
    func validationPayPassword(_ psd: String) {
        var params = [String: Any]()
        params["userid"] = User.currentUser().userId
        params["paymentpassword"] = psd
        
//        if psd == "123456" {
//            // MARK: 如何连续dismiss 2个VC视图控制器（以及直接跳回根视图）
//            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//            NotificationCenter.default.post(name: .cartOrderPaySuccess, object: nil)
//        }else {
//
//        }
        
        paySureView.boxView.clearLayer()
        
        WebAPITool.request(WebAPI.validationPayPassword(params), complete: { (value) in
            let success = value.boolValue
            if success {
                debugPrint("支付密码验证成功---\(value)")
                self.cartOrderPayment()
            }else {
                debugPrint("支付密码验失败")
                ZYToast.showCenterWithText(text: "支付密码不正确，请重新输入密码！")
            }
        }) { (error) in
            ZYToast.showCenterWithText(text: "支付密码验证失败！")
        }
        
    }
    
    func cartOrderPayment() {
        
        guard order_no != "" else {
            ZYToast.showCenterWithText(text: "订单号为空!")
            return
        }
        
        var params = [String: Any]()
        params["userid"] = User.currentUser().userId
        params["order_no"] = order_no
        
        debugPrints("用money支付购物车订单参数 ---\(params) ")
        
        HudHelper.showWaittingHUD(msg: "请稍后...")
        WebAPITool.request(WebAPI.cartOrderPayment(params), complete: { (value) in
            HudHelper.hideHUD()
            let success = value.boolValue
            if success {
                debugPrint("订单支付成功---\(value)")
                // MARK: 如何连续dismiss 2个VC视图控制器（以及直接跳回根视图）
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                self.dismiss()
                NotificationCenter.default.post(name: .cartOrderPaySuccess, object: nil)
            }else {
                debugPrint("订单支付失败")
            }
        }) { (error) in
            HudHelper.hideHUD()
            debugPrint("订单支付失败---\(error)")
        }
        
    }
}
