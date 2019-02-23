//
//  MineAddressPickerViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineAddressPickerViewController: SwiftPopup {

    var selectedAreaCompleted: ((_ province: String, _ city: String, _ district: String, _ town: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pickerView)
        pickerView.selectedAreaCompleted = { [weak self] (p,c,d,t) in
            guard let self = self else { return }
            self.dismiss()
            debugPrints("选择的区域---\(p)-\(c)-\(d)-\(t)")
            self.selectedAreaCompleted?(p, c, d, t)
        }
        
        pickerView.topView.cancelButton.rx.tap.subscribe(onNext: { [weak self]  (_) in
            guard let self = self else { return }
            self.dismiss()
        }).disposed(by: rx.disposeBag)
       
    }
    
    // MARK: - Lazy
    
    lazy var pickerView = MineAddressPicker.loadView()
   

}
