//
//  DeliveryOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/19.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 浏览用户所选菜单列表视图控制器
class DeliveryOrderViewController: SwiftPopup {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(orderView)
        
        orderView.cancelBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        orderSuccessView.cancelBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        orderSuccessView.sureBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe(onNext: { (gesture) in
            if !self.orderView.frame.contains(gesture.location(in: self.view)) {
                self.dismiss()
            }
            if !self.orderSuccessView.frame.contains(gesture.location(in: self.view)) {
                self.dismiss()
            }
        }).disposed(by: rx.disposeBag)
        view.addGestureRecognizer(tap)

        orderView.sureBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.dismiss()
            self.commitOrderClosure?()
        }).disposed(by: rx.disposeBag)
    }

    var commitOrderClosure:(()->Void)?

    // MAKR: - Lazy
    lazy var orderView = DeliveryOrderView.loadView()
    lazy var orderSuccessView = DeliveryOrderSuccessView.loadView()
    
}
