//
//  PaySelectViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class PaySelectViewController: SwiftPopup {
    
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
            self.paySelectView.status = .bag
        }).disposed(by: rx.disposeBag)
        
        paySelectView.wechatSelectBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.paySelectView.status = .wechat
        }).disposed(by: rx.disposeBag)
        
        paySelectView.alipaySelectBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.paySelectView.status = .alipay
        }).disposed(by: rx.disposeBag)
        
        paySelectView.sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.PayPasswordDemo.show(above: topVC, completion: nil)
        }).disposed(by: rx.disposeBag)
        
        payPasswordView.cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.paySelectView.status = .alipay
        }).disposed(by: rx.disposeBag)
        
    }
    
    // MARK: - Lazy
    lazy var paySureView = PaySureView.loadView()
    lazy var paySelectView = PaySelectView.loadView()
    lazy var paySuccessView = PaySuccessView.loadView()
    lazy var payPasswordView = PayPasswordView.loadView()
    lazy var PayPasswordDemo = PayPasswordViewController()
    
}
