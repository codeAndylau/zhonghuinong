//
//  PaySelectViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class PaySelectViewController: SwiftPopup {
    
    lazy var paySuccessView = PaySuccessView.loadView()
    lazy var paySureView = PaySureView.loadView()
    lazy var mineCenterView = MineCenterView.loadView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mineCenterView)
        
        paySuccessView.cancelBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        paySuccessView.orderBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        paySuccessView.continueBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe(onNext: { (gesture) in
            if !self.paySuccessView.frame.contains(gesture.location(in: self.view)) {
                self.dismiss()
            }
        }).disposed(by: rx.disposeBag)
        view.addGestureRecognizer(tap)
    }
    
    
}
