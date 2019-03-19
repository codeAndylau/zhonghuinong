//
//  SpecificationCollectionCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 蔬菜规格选择的cell
class SpecificationCollectionCell: CollectionViewCell,TabReuseIdentifier {
    
    let titleBtn = Button(type: .custom).then { (btn) in
        btn.setTitle("", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.backgroundColor = Color.theme1DD1A8
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        titleBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleBtn.cuttingCorner(radius: 15)
        //titleBtn.setupBorder(width: 1, color: UIColor.hexColor(0x979797))
    }
    
}
