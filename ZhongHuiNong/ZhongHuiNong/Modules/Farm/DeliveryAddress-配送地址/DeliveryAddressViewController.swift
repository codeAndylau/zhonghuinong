//
//  DeliveryAddressViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/19.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 配送地址选择
class DeliveryAddressViewController: SwiftPopup {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(addressView)
        
        addressView.cancelBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        addressModifyView.cancelBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe(onNext: { (gesture) in
            if !self.addressView.frame.contains(gesture.location(in: self.view)) {
                self.dismiss()
            }
            
            if !self.addressModifyView.frame.contains(gesture.location(in: self.view)) {
                self.dismiss()
            }
            
        }).disposed(by: rx.disposeBag)
        //view.addGestureRecognizer(tap)
        
        // 点击了翻转动画
        addressView.cellModifyDidClosure = { [weak self] index in
            guard let self = self else { return }
            UIView.transition(from: self.addressView , to: self.addressModifyView, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromLeft, completion: { (finish) in
                debugPrints("动画完成结果---\(finish)")
            })
        }
        
        addressModifyView.backBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            UIView.transition(from: self.addressModifyView , to: self.addressView, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromLeft, completion: { (finish) in
                debugPrints("动画完成结果---\(finish)")
            })
        }).disposed(by: rx.disposeBag)
        
        addressModifyView.sureBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            UIView.transition(from: self.addressModifyView , to: self.addressView, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromLeft, completion: { (finish) in
                debugPrints("动画完成结果---\(finish)")
            })
        }).disposed(by: rx.disposeBag)
        
        let tap1 = UITapGestureRecognizer()
        tap1.rx.event.subscribe(onNext: { [weak self] (gesture) in
            guard let self = self else { return }
            self.addressModifyView.endEditing(true)
        }).disposed(by: rx.disposeBag)
        addressModifyView.addGestureRecognizer(tap1)
        
        
        /// 监听键盘弹出通知
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillChangeFrameNotification).subscribe(onNext: { (notification) in
            
            if let userInfo = notification.userInfo,
                let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
                let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
                let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
                
                let frame = value.cgRectValue
                let intersection = frame.intersection(self.view.frame)
                debugPrints("键盘的frame---\(intersection.height)")
                UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
                    // CGRect(x: 0, y: kScreenH*0.45, width: kScreenW, height: kScreenH*0.55)
                    self.addressModifyView.frame = CGRect(x: 0, y: kScreenH*0.45-intersection.height, width: kScreenW, height: kScreenH*0.55)
                }, completion: nil)
            }
        }).disposed(by: rx.disposeBag)

    }
    

    // MAKR: - Lazy
    
    lazy var addressView = DeliveryAddressView.loadView()
    lazy var addressModifyView = DeliveryAddressModifyView.loadView()
    
}
