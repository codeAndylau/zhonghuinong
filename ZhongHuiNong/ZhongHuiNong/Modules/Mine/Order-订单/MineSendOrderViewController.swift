//
//  MineSendOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineSendOrderViewController: MineAllOrderViewController {

    override func makeUI() {
        super.makeUI()
        tableView.register(MineSendOrderTabCell.self, forCellReuseIdentifier: MineSendOrderTabCell.identifier)
    }

    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lazy

}

extension MineSendOrderViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineSendOrderTabCell.identifier, for: indexPath) as! MineSendOrderTabCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
