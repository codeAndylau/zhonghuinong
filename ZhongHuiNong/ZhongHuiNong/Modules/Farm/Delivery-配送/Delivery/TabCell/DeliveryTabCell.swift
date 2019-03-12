//
//  DeliveryTabCell.swift
//  ZhongHuiNong
//
//  Created by lau Andy on 2019/2/18.
//  Copyright © 2019年 Andylau. All rights reserved.
//

import UIKit

class DeliveryTabCell: TableViewCell, TabReuseIdentifier {

    lazy var leftImg: ImageView = {
        let img = ImageView()
        img.backgroundColor = Color.backdropColor
        img.cuttingCorner(radius: 6)
        return img
    }()
    
    lazy var titleLab: Label = {
        let lab = Label()
        lab.text = "西兰花"
        lab.font = UIFont.boldSystemFont(ofSize: 13)
        lab.textColor = UIColor.hexColor(0x333333)
        lab.numberOfLines = 0
        return lab
    }()
    
    lazy var numLab: Label = {
        let lab = Label()
        lab.text = "x3"
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.numberOfLines = 0
        return lab
    }()
    
    lazy var countLab: Label = {
        let lab = Label()
        lab.text = "500g"
        lab.font = UIFont.systemFont(ofSize: 11)
        lab.textColor = UIColor.hexColor(0x999999)
        lab.numberOfLines = 0
        return lab
    }()

    lazy var totalCountLab: Label = {
        let lab = Label()
        lab.text = ""
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textColor = UIColor.hexColor(0xB1B1B1)
        lab.numberOfLines = 0
        return lab
    }()
    
    override func makeUI() {
        super.makeUI()
        addSubview(leftImg)
        addSubview(titleLab)
        addSubview(numLab)
        addSubview(countLab)
        addSubview(totalCountLab)
    }
    
    override func updateUI() {
        super.updateUI()
        leftImg.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.centerY.equalTo(self)
            make.width.height.equalTo(44)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(leftImg.snp.top).offset(6)
            make.left.equalTo(leftImg.snp.right).offset(8)
            make.right.lessThanOrEqualTo(numLab.snp.left).offset(10)
        }
        
        numLab.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-30)
            make.centerY.equalTo(titleLab)
        }
        
        countLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom)
        }
        
        totalCountLab.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-30)
            make.centerY.equalTo(countLab)
        }
    }
    
    var info: DispatchOrderDetailInfo = DispatchOrderDetailInfo() {
        didSet {
            leftImg.lc_setImage(with: info.focusImgUrl)
            titleLab.text = info.productname
            countLab.text = "\(info.weight)g"
            numLab.text = "x\(info.quantity)"
        }
    }
}
