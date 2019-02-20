//
//  GoodsDetailRowView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/20.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class GoodsDetailRowView: View {

    let titleLab = Label().then { (lab) in
        lab.text = "已选"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let detailLab = Label().then { (lab) in
        lab.text = "500g x1"
        lab.textColor = UIColor.hexColor(0x000000)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let arrowImg = ImageView().then { (img) in
        img.image = UIImage(named: "basket_cancel")
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF5F5F5)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(detailLab)
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
        
        detailLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right).offset(30)
            make.top.bottom.equalTo(self)
            make.right.lessThanOrEqualTo(arrowImg.snp.left).offset(20)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
}
