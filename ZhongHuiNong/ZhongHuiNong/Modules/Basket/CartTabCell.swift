//
//  CartTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class CartTabCell: StoreRightCell {
    
    lazy var selectBtn: Button = {
        let btn = Button(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "store_jiahao"), for: .normal)
        return btn
    }()
    
    override func makeUI() {
        addSubview(selectBtn)
        addSubview(ImgView)
        addSubview(titleLab)
        addSubview(priceLab)
        addSubview(discountLab)
        addSubview(calculateView)
        calculateView.addSubview(jianhaoBtn)
        calculateView.addSubview(numLab)
        calculateView.addSubview(jiahaoBtn)
    }
    
    override func updateUI() {
        activateConstraints()
    }

    func activateConstraints() {
        selectBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.width.height.equalTo(50)
        }
        
        ImgView.snp.makeConstraints { (make) in
            make.left.equalTo(selectBtn.snp.right)
            make.centerY.equalTo(self)
            make.width.height.equalTo(95)
        }

        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(ImgView.snp.top)
            make.left.equalTo(ImgView.snp.right).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.lessThanOrEqualTo(calculateView.snp.top).offset(-5)
        }

        calculateView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(70)
            make.height.equalTo(25)
        }

        priceLab.snp.makeConstraints { (make) in
            make.left.equalTo(ImgView.snp.right).offset(15)
            make.bottom.equalTo(ImgView.snp.bottom)
        }

        discountLab.snp.makeConstraints { (make) in
            make.left.equalTo(priceLab.snp.right).offset(5)
            make.bottom.equalTo(ImgView.snp.bottom).offset(-5)
        }

        jianhaoBtn.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.centerY.equalTo(calculateView)
            make.width.height.equalTo(25)
        }

        numLab.snp.makeConstraints { (make) in
            make.center.equalTo(calculateView)
            make.width.height.equalTo(20)
        }

        jiahaoBtn.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.centerY.equalTo(calculateView)
            make.width.height.equalTo(25)
        }
    }

}
