//
//  MineCustomerTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/27.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineCustomerTabCell: TableViewCell, TabReuseIdentifier {

    let contView = View().then { (view) in
        view.backgroundColor = Color.whiteColor
    }
    
    let topImg = ImageView().then { (img) in
        img.backgroundColor = Color.whiteColor
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "在线客服-售后"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let detailLab = Label().then { (lab) in
        lab.text = "疑问咨询"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.numberOfLines = 0
    }
    
    let dateLab = Label().then { (lab) in
        lab.text = "15:20"
        lab.textColor = UIColor.hexColor(0xC8C8C8)
        lab.textAlignment = .right
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(contView)
        contView.addSubview(topImg)
        contView.addSubview(titleLab)
        contView.addSubview(detailLab)
        contView.addSubview(dateLab)
        
    }
    
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12))
        }
        
        topImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(topImg).offset(3)
            make.left.equalTo(topImg.snp.right).offset(12)
        }
        
        dateLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalTo(titleLab)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(5)
            make.left.equalTo(titleLab)
            make.right.equalToSuperview().offset(-12)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // shadowCode
        contView.layer.shadowColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.2).cgColor
        contView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contView.layer.shadowOpacity = 1
        contView.layer.shadowRadius = 5
        contView.layer.cornerRadius = 10
    }

}
