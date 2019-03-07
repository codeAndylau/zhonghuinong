//
//  MineSettingTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineSettingTabCell: TableViewCell, TabReuseIdentifier {

    let titleLab = Label().then { (lab) in
        lab.text = "头像"
        lab.textColor = UIColor.hexColor(0x524C4A)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let detailLab = Label().then { (lab) in
        lab.text = "135****8888"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let headerImg = ImageView().then { (img) in
        img.image = UIImage(named: "mine_default_ portrait")
        img.cuttingCorner(radius: 55/2)
    }
    
    let switchView = UISwitch()
    
    let arrowImg = ImageView().then { (img) in
        img.image = UIImage(named: "mine_arrow")
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF5F5F5)
    }
    
    var isArrow = false {
        didSet {
            headerImg.isHidden = true
            detailLab.isHidden = true
            switchView.isHidden = true
            lineView.isHidden = true
        }
    }
    
    var isHeader = false {
        didSet {
            detailLab.isHidden = true
            switchView.isHidden = true
        }
    }
    
    var isTitle = false {
        didSet {
            headerImg.isHidden = true
            switchView.isHidden = true
        }
    }
    
    var isSwitch = false {
        didSet {
            detailLab.isHidden = true
            headerImg.isHidden = true
            arrowImg.isHidden = true
        }
    }
    
    var isAddress = false {
        didSet {
            detailLab.isHidden = true
            headerImg.isHidden = true
            switchView.isHidden = true
            lineView.isHidden = true
        }
    }
    
    var isLine = false {
        didSet {
            lineView.isHidden = true
        }
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(detailLab)
        addSubview(headerImg)
        addSubview(switchView)
        addSubview(arrowImg)
        addSubview(lineView)
    }
    
    override func updateUI() {
        super.updateUI()
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
        }
        
        headerImg.snp.makeConstraints { (make) in
            make.right.equalTo(arrowImg.snp.left).offset(-15)
            make.centerY.equalTo(self)
            make.width.height.equalTo(55)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.right.equalTo(arrowImg.snp.left).offset(-15)
            make.centerY.equalTo(self)
        }
        
        switchView.snp.makeConstraints { (make) in
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
    
    

}
