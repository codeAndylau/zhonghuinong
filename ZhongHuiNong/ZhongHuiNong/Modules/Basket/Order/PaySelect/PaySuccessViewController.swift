//
//  PaySuccessViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 支付成功后的界面
class PaySuccessViewController: SwiftPopup {
    
    var disMissClosure: BtnAction?
    var btnClosure: IndexAction?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(paySuccessView)
        
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe(onNext: { [weak self] (gesture) in
            guard let self = self else { return }
            if !self.paySuccessView.frame.contains(gesture.location(in: self.view)) {
                self.dismiss()
                self.disMissClosure?()
            }
        }).disposed(by: rx.disposeBag)
        view.addGestureRecognizer(tap)

        paySuccessView.cancelBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.dismiss()
            self.disMissClosure?()
        }).disposed(by: rx.disposeBag)
        
        /// 支付成功界面的按钮点击操作
        
        paySuccessView.orderBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.dismiss()
            self.btnClosure?(1)
        }).disposed(by: rx.disposeBag)
        
        paySuccessView.continueBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.dismiss()
            self.btnClosure?(2)
        }).disposed(by: rx.disposeBag)
        
        
        
    }

    // MARK: - Navigation
    lazy var paySuccessView = PaySuccessView.loadView()

}
