//
//  StoreRightCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class StoreRightCell: TableViewCell, TabReuseIdentifier {
    
    lazy var ImgView: ImageView = {
        let img = ImageView()
        img.backgroundColor = Color.backdropColor
        img.cuttingCorner(radius: 6)
        return img
    }()
    
    lazy var titleLab: Label = {
        let lab = Label()
        lab.text = "新鲜草莓500g/份"
        lab.font = UIFont.boldSystemFont(ofSize: 15)
        lab.textColor = UIColor.hexColor(0x333333)
        lab.numberOfLines = 0
        return lab
    }()
    
    lazy var priceLab: Label = {
        let lab = Label()
        lab.text = "¥16.6"
        lab.font = UIFont.systemFont(ofSize: 19)
        lab.textColor = UIColor.hexColor(0x1DD1A8)
        lab.numberOfLines = 0
        return lab
    }()
    
    lazy var discountLab: Label = {
        let lab = Label()
        lab.text = "¥46.6"
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textColor = UIColor.hexColor(0xB1B1B1)
        lab.numberOfLines = 0
        return lab
    }()
    
    override func makeUI() {
        super.makeUI()
        addSubview(ImgView)
        addSubview(titleLab)
        addSubview(priceLab)
        addSubview(discountLab)
    }
    
    override func updateUI() {
        super.updateUI()
        
        ImgView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
            make.width.height.equalTo(90)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(ImgView.snp.top)
            make.left.equalTo(ImgView.snp.right).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.lessThanOrEqualTo(priceLab.snp.top).offset(-5)
        }

        priceLab.snp.makeConstraints { (make) in
            make.left.equalTo(ImgView.snp.right).offset(15)
            make.bottom.equalTo(ImgView.snp.bottom)
        }
        
        discountLab.snp.makeConstraints { (make) in
            make.left.equalTo(priceLab.snp.right).offset(5)
            make.bottom.equalTo(ImgView.snp.bottom).offset(-5)
        }

    }
    
    var model: GoodsInfo = GoodsInfo() {
        didSet {
            ImgView.lc_setImage(with: model.focusImgUrl)
            titleLab.text = model.productName
            priceLab.text = "¥\(String(describing: model.salePrice))"      // 销售价格
            discountLab.text = "¥\(String(describing: model.marketPrice))" // 市场价格
        }
    }
    
}
