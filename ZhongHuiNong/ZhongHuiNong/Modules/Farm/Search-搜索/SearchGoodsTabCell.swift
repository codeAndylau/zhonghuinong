//
//  SearchGoodsTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/14.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class SearchGoodsTabCell: StoreRightCell {

    override func makeUI() {
        
        addSubview(ImgView)
        addSubview(titleLab)
        addSubview(priceLab)
        addSubview(discountLab)
    }
    
    override func updateUI() {
        
        ImgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.width.height.equalTo(90)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(ImgView.snp.top).offset(8)
            make.left.equalTo(ImgView.snp.right).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.lessThanOrEqualTo(priceLab.snp.top).offset(-5)
        }

        priceLab.snp.makeConstraints { (make) in
            make.left.equalTo(ImgView.snp.right).offset(15)
            make.bottom.equalTo(ImgView.snp.bottom).offset(-8)
        }
        
        discountLab.snp.makeConstraints { (make) in
            make.left.equalTo(priceLab.snp.right).offset(5)
            make.bottom.equalTo(ImgView.snp.bottom).offset(-13)
        }

    }
    
    
    var goodsInfo: GoodsInfo = GoodsInfo() {
        didSet {
            ImgView.lc_setImage(with: goodsInfo.focusImgUrl)
            titleLab.text = goodsInfo.productName
            priceLab.text = "¥\(String(describing: goodsInfo.salePrice))"      // 销售价格
            discountLab.text = "¥\(String(describing: goodsInfo.marketPrice))" // 市场价格
        }
    }
    
}
