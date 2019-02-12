//
//  PaySelectViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class PaySelectViewController: SwiftPopup {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let popView = UIView(frame: CGRect(x: 0, y: kScreenH-400, width: kScreenW, height: 400))
        popView.backgroundColor = UIColor.orange
        view.addSubview(popView)
    }


}
