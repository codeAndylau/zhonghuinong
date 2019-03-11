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
        img.cuttingCorner(radius: 8)
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "精选孢子甘蓝"
        lab.textAlignment = .center
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    let detailLab = Label().then { (lab) in
        lab.text = "g"
        lab.textAlignment = .center
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let addView = AddSelectedView().then { (view) in
        view.backgroundColor = Color.whiteColor
        view.numLab.text = "0"
    }
    
    override func makeUI() {
        super.makeUI()
        backgroundColor = UIColor.white
        addSubview(topImg)
        addSubview(titleLab)
        addSubview(detailLab)
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
            make.top.equalTo(topImg.snp.bottom).offset(5)
            make.left.right.equalTo(self)
            make.height.equalTo(16)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom)
            make.left.right.equalTo(self)
        }
        
        addView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.centerX.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
    
    var Info: DispatchMenuInfo = DispatchMenuInfo() {
        didSet {
            topImg.lc_setImage(with: Info.focusImgUrl)
            titleLab.text = Info.producename 
            detailLab.text = "\(Info.unitweight)" + "g"
            addView.numLab.text = "\(Info.num)"
        }
    }
}
