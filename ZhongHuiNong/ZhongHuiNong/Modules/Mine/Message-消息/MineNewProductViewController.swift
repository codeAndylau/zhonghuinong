//
//  MineNewProductViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/27.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineNewProductViewController: MineMsgComponentViewController {

    override func makeUI() {
        super.makeUI()
        view.backgroundColor = UIColor.cyan
        tableView.register(MineNewProductTabCell.self, forCellReuseIdentifier: MineNewProductTabCell.identifier)
    }
    
    //  MARK: - Lazy

  
}

extension MineNewProductViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineNewProductTabCell.identifier, for: indexPath) as! MineNewProductTabCell
        if indexPath.row == 1 {
            cell.model = "昨天15:20"
        }
        if indexPath.row == 2 {
            cell.model = "周一5:20"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  self.navigator.show(segue: .goodsDetail, sender: self.topMost)
    }
    
}
