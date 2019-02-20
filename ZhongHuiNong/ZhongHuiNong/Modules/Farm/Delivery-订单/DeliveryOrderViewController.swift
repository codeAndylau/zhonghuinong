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
        
        orderView.day2Btn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.orderView.dataArray = 5
            self.orderView.day2Height()
        }).disposed(by: rx.disposeBag)
        
        orderView.day5Btn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.orderView.dataArray = 8
            self.orderView.isDay5 = true
            self.orderView.day5Height()
        }).disposed(by: rx.disposeBag)
        
        orderView.sureBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            
            // 星期五
            guard self.orderView.isDay5 else {
                self.orderView.isDay5 = true
                self.orderView.day5Height()
                ZYToast.showCenterWithText(text: "请确认周五的菜单")
                return
            }
            
            ZYToast.showCenterWithText(text: "菜单提交成功")
            
            UIView.transition(from: self.orderView , to: self.orderSuccessView, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromLeft, completion: { (finish) in
                debugPrints("动画完成结果---\(finish)")
            })
            
            
        }).disposed(by: rx.disposeBag)
    }


    // MAKR: - Lazy
    
    lazy var orderView = DeliveryOrderView.loadView()
    lazy var orderSuccessView = DeliveryOrderSuccessView.loadView()
    
}
