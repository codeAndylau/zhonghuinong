//
//  StoreLeftCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class StoreLeftCell: TableViewCell, TabReuseIdentifier {
    
    var isShow: Bool = false {
        didSet {
            lineView.isHidden = !isShow
            if isShow {
                titleLab.textColor = Color.theme1DD1A8
            }else {
                titleLab.textColor = UIColor.hexColor(0x666666)
            }
        }
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = Color.theme1DD1A8
        view.cuttingCorner(radius: 2)
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "#666666"
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func makeUI() {
        super.makeUI()
        
        addSubview(lineView)
        addSubview(titleLab)
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(3)
            make.height.equalTo(12)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
