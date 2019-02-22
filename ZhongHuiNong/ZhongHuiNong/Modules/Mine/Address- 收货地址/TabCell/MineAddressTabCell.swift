//
//  MineAddressTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineAddressTabCell: TableViewCell,TabReuseIdentifier {
    
    let titleLab = Label().then { (lab) in
        lab.text = "四川省成都市成华区天府新区高新区滨河花园A1栋1单元1号"
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.numberOfLines = 0
    }
    
    let phoneLab = Label().then { (lab) in
        lab.text = "姚娜娜 13588888888"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let defaultLab = Label().then { (lab) in
        lab.text = "默认地址"
        lab.textAlignment = .center
        lab.textColor = UIColor.hexColor(0x1DD1A8)
        lab.font = UIFont.systemFont(ofSize: 10)
        lab.cuttingCorner(radius: 10)
        lab.setupBorder(width: 1, color: UIColor.hexColor(0x1DD1A8))
        lab.backgroundColor = UIColor.hexColor(0x1DD1A8, alpha: 0.17)
    }
    
    let editBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_modify"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF5F5F5)
    }
    
    var isDefault = false {
        didSet {
            defaultLab.isHidden = false
        }
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(phoneLab)
        addSubview(editBtn)
        addSubview(defaultLab)
        addSubview(lineView)
        defaultLab.isHidden = true
    }
    
    override func updateUI() {
        super.updateUI()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(12)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-50)
            make.bottom.equalTo(phoneLab.snp.top).offset(5)
        }
        
        phoneLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.bottom.equalTo(self).offset(-10)
            make.height.equalTo(17)
        }
        
        defaultLab.snp.makeConstraints { (make) in
            make.left.equalTo(phoneLab.snp.right).offset(10)
            make.centerY.equalTo(phoneLab)
            make.width.equalTo(55)
            make.height.equalTo(20)
        }
        
        editBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    
    
   
}
