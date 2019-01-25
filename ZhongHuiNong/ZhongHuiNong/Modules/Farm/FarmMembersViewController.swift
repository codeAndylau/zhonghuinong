//
//  FarmMembersViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 农场会员
class FarmMembersViewController: TableViewController {
    
    let segmentedControl = FarmSegmentedView().then { (view) in
        view.frame = CGRect(x: 20, y: 150, width: kScreenW - 40, height: 40)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(segmentedControl)
    }
    
}
