//
//  PaySelectViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 支付选择试图控制器(账户余额支付，支付宝，微信)
class PaySelectViewController: SwiftPopup {
    
    var order_no: String = ""
    
    var money: CGFloat = 0 {
        didSet {
            let price = Keepfigures(text: money)
            debugPrints("支付money---\(price)")
            paySelectView.moneyLab.text = price
        }
    }
    
    var balance: Double = 0 {
        didSet {
            let price = Keepfigures(text: CGFloat(balance))
            paySelectView.balanceLab.text =  "可用余额\(price)元"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(paySelectView)
        
        paySuccessView.cancelBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        paySuccessView.orderBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        paySuccessView.continueBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        paySelectView.cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe(onNext: { (gesture) in
            if !self.paySuccessView.frame.contains(gesture.location(in: self.view)) {
                self.dismiss()
            }
        }).disposed(by: rx.disposeBag)
        view.addGestureRecognizer(tap)
        
        // 支付选择逻辑处理
        paySelectView.bagSelectBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.paySelectView.bagSelectBtn.isSelected = !self.paySelectView.bagSelectBtn.isSelected
        }).disposed(by: rx.disposeBag)
        
        paySelectView.wechatSelectBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.paySelectView.status = .wechat
        }).disposed(by: rx.disposeBag)
        
        paySelectView.alipaySelectBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.paySelectView.status = .alipay
        }).disposed(by: rx.disposeBag)
        
        /// 余额支付
        paySelectView.sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.validationMoney()
        }).disposed(by: rx.disposeBag)
        
        payPasswordView.cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.paySelectView.status = .alipay
        }).disposed(by: rx.disposeBag)
        
    }
    
    deinit {
        debugPrints("支付方式选择界面已经销毁")
    }
    
    // MARK: - Lazy
    
    lazy var paySureView = PaySureView.loadView()
    
    lazy var paySelectView = PaySelectView.loadView()
    
    lazy var paySuccessView = PaySuccessView.loadView()
    
    lazy var payPasswordView = PayPasswordView.loadView()
    
    lazy var PayPasswordDemo = PayPasswordViewController()
    
    
    // MARK: - Action
    
    func validationMoney() {
        
        if CGFloat(balance) >= money {
            self.PayPasswordDemo.order_no = self.order_no
            self.PayPasswordDemo.show(above: topVC, completion: nil)
        }else {
            ZYToast.showCenterWithText(text: "您的余额不足,请联系客服充值")
        }
        
    }
    
}
