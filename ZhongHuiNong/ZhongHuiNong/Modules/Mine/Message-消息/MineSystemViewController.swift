//
//  MineSystemViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/27.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineSystemViewController: MineMsgComponentViewController {

    override func makeUI() {
        super.makeUI()
        view.backgroundColor = UIColor.orange
        tableView.register(MineSystemTabCell.self, forCellReuseIdentifier: MineSystemTabCell.identifier)
    }
    
    //  MARK: - Lazy

}

extension MineSystemViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineSystemTabCell.identifier, for: indexPath) as! MineSystemTabCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  self.navigator.show(segue: .goodsDetail, sender: self.topMost)
    }
    
}
