//
//  DeliveryOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/19.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryOrderViewController: SwiftPopup {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(orderView)
        
        orderView.cancelBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe(onNext: { (gesture) in
            if !self.orderView.frame.contains(gesture.location(in: self.view)) {
                self.dismiss()
            }
        }).disposed(by: rx.disposeBag)
        view.addGestureRecognizer(tap)
        
        orderView.day2Btn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.orderView.dataArray = 5
        }).disposed(by: rx.disposeBag)
        
        orderView.day5Btn.rx.tap.subscribe(onNext: { (_) in
            self.orderView.dataArray = 8
        }).disposed(by: rx.disposeBag)
    }


    // MAKR: - Lazy
    
    lazy var orderView = DeliveryOrderView.loadView()
    
}
