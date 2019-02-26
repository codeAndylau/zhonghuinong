//
//  HotMeatViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/26.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class HotMeatViewController: ComponentViewController {
    
    override func makeUI() {
        super.makeUI()
        view.backgroundColor = UIColor.black
    }
    
}

extension HotMeatViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
}
