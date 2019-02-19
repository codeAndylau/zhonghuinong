//
//  DeliveryAddressTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/19.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryAddressTabCell: TableViewCell, TabReuseIdentifier {

    let selectBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_modify"), for: .normal)
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "四川省成都市成华区天府新区高新区滨河花园A1栋1单元1号"
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.numberOfLines = 0
    }
    
    let phoneLab = Label().then { (lab) in
        lab.text = "姚娜娜  13588888888"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let modifyBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_modify"), for: .normal)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(selectBtn)
        addSubview(titleLab)
        addSubview(phoneLab)
        addSubview(modifyBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        
        selectBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.width.height.equalTo(35)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(selectBtn.snp.right).offset(15)
            make.bottom.equalTo(phoneLab.snp.top).offset(5)
            make.right.lessThanOrEqualTo(self).offset(-50)
        }
        
        
        phoneLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab)
            make.bottom.equalTo(self).offset(-5)
        }
        
        modifyBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
        }
        
    }


}
