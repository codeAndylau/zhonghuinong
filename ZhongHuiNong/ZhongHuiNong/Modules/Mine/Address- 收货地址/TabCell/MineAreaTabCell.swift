//
//  MineAreaTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineAreaTabCell: TableViewCell, TabReuseIdentifier {

    let titleLab = Label().then { (lab) in
        lab.text = ""
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 15)
    }
    
    let imgView = ImageView()
    
    var isSelect: Bool = false {
        didSet {
            imgView.image = isSelect ? UIImage(named:"mine_address_selected") : UIImage()
            titleLab.textColor = isSelect ? UIColor.hexColor(0x1DD1A8) : UIColor.hexColor(0x4A4A4A)
        }
    }
    
    override func makeUI() {
        super.makeUI()
        selectionStyle = .none
        addSubview(titleLab)
        addSubview(imgView)
    }
    
    override func updateUI() {
        super.updateUI()
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        }
        
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right).offset(5)
            make.centerY.equalTo(self)
            make.width.equalTo(14)
            make.height.equalTo(11)
        }
    }
 

}
