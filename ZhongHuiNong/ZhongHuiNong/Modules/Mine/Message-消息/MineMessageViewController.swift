//
//  MineMessageViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineMessageViewController: ViewController {

    override func makeUI() {
        super.makeUI()
        navigationItem.title = "消息提醒"
        view.addSubview(empty)
    }
    
    override func updateUI() {
        super.updateUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lazy
    
    lazy var empty = MineMessageEmptyView.loadView()

}
