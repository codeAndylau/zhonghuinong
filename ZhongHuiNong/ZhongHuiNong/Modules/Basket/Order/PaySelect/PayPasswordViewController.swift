//
//  PayPasswordViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class PayPasswordViewController: SwiftPopup {

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
            debugPrints("输入的密码是---\(psd)")
            self.dismiss()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        debugPrints("输入的密码是---")
        //        self.paySureView.boxView.clearLayer()
    }
    
    // MARK: - Lazy
    lazy var paySureView = PayPasswordView.loadView()

}
