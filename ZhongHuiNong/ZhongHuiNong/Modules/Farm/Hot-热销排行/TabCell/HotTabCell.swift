//
//  HotTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/26.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class HotTabCell: FlashOneTabCell {

    var hotView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xFF5959)
        view.cuttingCorner(radius: 7)
    }
    
    var tipsLab = Label().then { (lab) in
        lab.text = "热卖指数100"
        lab.font = UIFont.boldSystemFont(ofSize: 10)
        lab.textColor = UIColor.white
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(hotView)
        hotView.addSubview(tipsLab)
    }
    
    override func updateUI() {
        super.updateUI()
        hotView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(2)
            make.width.equalTo(75)
            make.height.equalTo(14)
        }
        
        tipsLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(6)
            make.centerY.equalToSuperview()
        }
        
    }

}
