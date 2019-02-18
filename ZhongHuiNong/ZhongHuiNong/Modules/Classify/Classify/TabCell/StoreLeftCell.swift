//
//  StoreLeftCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class StoreLeftCell: TableViewCell, TabReuseIdentifier {

    lazy var ImgView = UIImageView()
    
    override func makeUI() {
        super.makeUI()
        addSubview(ImgView)
        ImgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
