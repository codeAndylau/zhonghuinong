//
//  GoodsDetailImgTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/9.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class GoodsDetailImgTabCell: TableViewCell, TabReuseIdentifier {

    let imgView = ImageView().then { (img) in
        img.contentMode = UIView.ContentMode.scaleAspectFit
    }
    
    override func makeUI() {
        
        addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

}
