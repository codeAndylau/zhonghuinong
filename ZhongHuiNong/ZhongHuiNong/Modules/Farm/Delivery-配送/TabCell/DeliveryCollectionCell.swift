//
//  DeliveryCollectionCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryCollectionCell: CollectionViewCell, TabReuseIdentifier {
    
    let topImg = ImageView().then { (img) in
        img.image = UIImage(named: "mine_vip_1")
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "精选孢子甘蓝"
        lab.textAlignment = .center
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    let addView = AddSelectedView().then { (view) in
        view.backgroundColor = Color.whiteColor
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(topImg)
        addSubview(titleLab)
        addSubview(addView)
    }
    
    override func updateUI() {
        super.updateUI()
        
        topImg.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW/3-16)
            make.height.equalTo(width)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(topImg.snp.bottom).offset(8)
            make.left.right.equalTo(self)
            make.height.equalTo(16)
        }
        
        addView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.centerX.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
}
