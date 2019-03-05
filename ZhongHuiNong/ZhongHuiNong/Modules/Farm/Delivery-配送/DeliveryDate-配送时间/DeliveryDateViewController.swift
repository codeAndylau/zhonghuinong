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

    }

    // MAKR: - Lazy
    lazy var dateView = DeliveryTimeView.loadView()
    
}
