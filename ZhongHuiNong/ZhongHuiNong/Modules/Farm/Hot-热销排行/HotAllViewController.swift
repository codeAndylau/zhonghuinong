//
//  HotAllViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/26.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class HotAllViewController: ComponentViewController {

    override func makeUI() {
        super.makeUI()
        view.backgroundColor = UIColor.orange
    }

}

extension HotAllViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
}
