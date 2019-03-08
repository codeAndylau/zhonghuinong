//
//  MineSettingPayPsdViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/8.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineSettingPayPsdViewController: SwiftPopup {
    
    var psdArray: [String] = []
    
    var inputCompleteClosure: ((_ text: String)->Void)?

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
            self.psdArray.append(psd)
            debugPrints("输入的密码是---\(psd)---\(self.psdArray)")
            if self.psdArray.count == 1 {
                self.paySureView.boxView.clearLayer()
                ZYToast.showCenterWithText(text: "请再次输入密码")
            }
            if self.psdArray.count == 2 {
                if self.psdArray[0] == self.psdArray[1] {
                    self.dismiss()
                    self.inputCompleteClosure?(self.psdArray[0])
                }else {
                    self.psdArray.remove(at: 1)
                    self.paySureView.boxView.clearLayer()
                    ZYToast.showCenterWithText(text: "两次输入的密码不一致，请重新输入")
                }
            }
        }
    }

    // MARK: - Lazy
    lazy var paySureView = PayPasswordView.loadView().then { (view) in
        view.payLab.text = "请设置支付密码，用于支付验证"
        view.payLab.font = UIFont.systemFont(ofSize: 16)
    }
    
}
