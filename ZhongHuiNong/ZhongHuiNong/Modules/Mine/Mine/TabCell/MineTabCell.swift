//
//  MineTabCell.swift
//  ZhongHuiNong
//
//  Created by lau Andy on 2019/2/10.
//  Copyright © 2019年 Andylau. All rights reserved.
//

import UIKit

class MineTabCell: TableViewCell, TabReuseIdentifier {

    let titleLab = Label().then { (lab) in
        lab.text = "我的地块"
        lab.textColor = UIColor.hexColor(0x524C4A)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let arrowImg = ImageView().then { (img) in
        img.image = UIImage(named: "farm_arrow")
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = Color.backdropColor
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(arrowImg)
        addSubview(lineView)
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.centerY.equalTo(self)
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.right.equalTo(self).inset(15)
            make.centerY.equalTo(self)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).inset(15)
            make.bottom.equalTo(self)
            make.height.equalTo(0.5)
        }
    }

}
