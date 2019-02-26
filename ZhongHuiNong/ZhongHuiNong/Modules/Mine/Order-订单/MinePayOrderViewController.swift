//
//  MinePayOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MinePayOrderViewController: MineAllOrderViewController {

    override func makeUI() {
        super.makeUI()
        tableView.register(MinePayOrderTabCell.self, forCellReuseIdentifier: MinePayOrderTabCell.identifier)
    }

    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lazy

}

extension MinePayOrderViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MinePayOrderTabCell.identifier, for: indexPath) as! MinePayOrderTabCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
