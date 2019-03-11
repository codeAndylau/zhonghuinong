//
//  DeliveryDateViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/4.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryDateViewController: SwiftPopup {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dateView)
        
        // 点击了取消按钮
        dateView.cancelBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        
        // 点击背景试图
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe(onNext: { (gesture) in
            if !self.dateView.frame.contains(gesture.location(in: self.view)) {
                self.dismiss()
            }
        }).disposed(by: rx.disposeBag)
        view.addGestureRecognizer(tap)
        
    }

    // MAKR: - Lazy
    lazy var dateView = DeliveryTimeView.loadView()
    
}
