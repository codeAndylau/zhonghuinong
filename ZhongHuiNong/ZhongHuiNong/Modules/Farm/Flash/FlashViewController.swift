//
//  FlashViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/15.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class FlashViewController: ViewController {
    
    let topView = FlashView().then { (v) in
        v.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 120+kStaBarH)
        v.backgroundColor = UIColor.red
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.backdropColor
        navigationController?.navigationBar.isHidden = true
        statusBarStyle.accept(true)
    }

    override func makeUI() {
        super.makeUI()
        view.addSubview(topView)
    }
    
    override func updateUI() {
        super.updateUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }

}
