//
//  MineWalletTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineWalletTabCell: TableViewCell, TabReuseIdentifier {

    let titleLab = Label().then { (lab) in
        lab.text = "商城购物"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.textAlignment = .left
        lab.font = UIFont(name: "Semibold", size: 14)
    }
    
    let moneyLab = Label().then { (lab) in
        lab.text = "-¥68.58"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.textAlignment = .right
        lab.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    let timeLab = Label().then { (lab) in
        lab.text = "2月7日 19:30"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.textAlignment = .left
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF5F5F5)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(lineView)
        addSubview(titleLab)
        addSubview(moneyLab)
        addSubview(timeLab)
    }
    
    override func updateUI() {
        super.updateUI()
        
        lineView.snp.makeConstraints { (make) in
            make.bottom.centerX.equalTo(self)
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(1)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(10)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom)
        }
        
        moneyLab.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
        }
    }

}
