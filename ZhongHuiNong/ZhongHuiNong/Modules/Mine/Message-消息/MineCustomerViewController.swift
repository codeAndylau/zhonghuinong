//
//  MineCustomerViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/27.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineCustomerViewController: MineMsgComponentViewController {

    override func makeUI() {
        super.makeUI()
        view.backgroundColor = UIColor.blue
        tableView.register(MineCustomerTabCell.self, forCellReuseIdentifier: MineCustomerTabCell.identifier)
    }
    
    //  MARK: - Lazy
    lazy var imgArray = ["mine_msg_shouqian","mine_msg_shouhou","mine_msg_vip"]
    lazy var TitleArray = ["在线客服-售前","在线客服-售后","在线客服-尊享VIP"]

}

extension MineCustomerViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineCustomerTabCell.identifier, for: indexPath) as! MineCustomerTabCell
        cell.topImg.image = UIImage(named: imgArray[indexPath.row])
        cell.titleLab.text = TitleArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  self.navigator.show(segue: .goodsDetail, sender: self.topMost)
    }
    
}
