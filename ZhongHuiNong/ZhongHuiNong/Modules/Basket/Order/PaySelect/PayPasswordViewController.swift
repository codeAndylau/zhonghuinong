//
//  PayPasswordViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import MBProgressHUD

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
    
    override  func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        paySureView.boxView.clearLayer()
    }
    
    deinit {
        debugPrints("支付密码框界面已经销毁")
    }
    
    // MARK: - Lazy
    
    lazy var paySureView = PayPasswordView.loadView()

    /// 支付成功毁掉
    var paySuccessClosure: (()->Void)?

    
    // MARK: - Action
    
    /// 验证支付密码
    func validationPayPassword(_ psd: String) {
        
        var params = [String: Any]()
        params["userid"] = User.currentUser().userId
        params["paymentpassword"] = psd

        WebAPITool.request(WebAPI.validationPayPassword(params), complete: { (value) in
            let success = value.boolValue
            if success {
                debugPrint("支付密码验证成功---\(value)")
                self.cartOrderPayment()
            }else {
                debugPrint("支付密码验失败")
                self.paySureView.boxView.clearLayer()
                ZYToast.showCenterWithText(text: "支付密码不正确，请重新输入密码！")
            }
        }) { (error) in
            ZYToast.showCenterWithText(text: "支付密码验证失败！")
        }
        
    }
    
    /// 用额度支付
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
            debugPrint("用账户余额支付后返回的参数--\(value)")
            
            let status = value["status"].intValue
            let detail = value["detail"].stringValue
            
            if status == 1 {
                mainQueue {
                    self.dismiss(completion: {
                        self.paySureView.boxView.clearLayer()
                        self.paySuccessClosure?()
                    })
                }
            }else {
                self.dismiss()
                self.paySureView.boxView.clearLayer()
                MBProgressHUD.showError(detail)
            }
            
        }) { (error) in
            self.dismiss()
            self.paySureView.boxView.clearLayer()
            HudHelper.hideHUD()
            MBProgressHUD.showError("余额支付失败")
            debugPrint("订单支付失败---\(error)")
        }
        
    }
}


/*
 // MARK: 如何连续dismiss 2个VC视图控制器（以及直接跳回根视图）
 self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
 self.dismiss()
 */
