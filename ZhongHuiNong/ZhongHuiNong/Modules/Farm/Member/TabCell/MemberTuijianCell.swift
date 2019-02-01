//
//  MemberTuijianCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MemberTuijianCell: TableViewCell, TabReuseIdentifier {
    
    lazy var imgView = UIImageView(image: UIImage(named: "goods_tuijian_1"))
    
    override func makeUI() {
        super.makeUI()
        addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(8)
            make.bottom.equalTo(self).offset(-8)
        }

    }
    
}
