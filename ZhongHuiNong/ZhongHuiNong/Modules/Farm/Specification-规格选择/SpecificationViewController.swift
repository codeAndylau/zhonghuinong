//
//  SpecificationViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class SpecificationViewController: SwiftPopup {

    lazy var specificationView = SpecificationSelectedView.loadView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(specificationView)
        
        specificationView.sureBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        specificationView.cancelBtn.rx.tap.subscribe(onNext: { (_) in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe(onNext: { (gesture) in
            if !self.specificationView.frame.contains(gesture.location(in: self.view)) {
                self.dismiss()
            }
        }).disposed(by: rx.disposeBag)
        view.addGestureRecognizer(tap)
    }

}
