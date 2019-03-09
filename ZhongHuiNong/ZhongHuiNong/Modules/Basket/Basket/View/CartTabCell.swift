//
//  CartTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class CartTabCell: StoreRightCell {
    
    let addView = AddSelectedView()
    
    lazy var selectBtn: Button = {
        let btn = Button(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "mine_order_unselected"), for: .normal)
        btn.setImage(UIImage(named: "mine_order_selected"), for: .selected)
        btn.isSelected = false
        btn.addTarget(self, action: #selector(selectedAction), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    override func makeUI() {
        addSubview(selectBtn)
        addSubview(ImgView)
        addSubview(titleLab)
        addSubview(priceLab)
        addSubview(discountLab)
        addSubview(addView)
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
            make.bottom.lessThanOrEqualTo(priceLab.snp.top).offset(-5)
        }

        priceLab.snp.makeConstraints { (make) in
            make.left.equalTo(ImgView.snp.right).offset(15)
            make.bottom.equalTo(ImgView.snp.bottom)
        }

        discountLab.snp.makeConstraints { (make) in
            make.left.equalTo(priceLab.snp.right).offset(5)
            make.bottom.equalTo(ImgView.snp.bottom).offset(-2)
        }

        addView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(ImgView.snp.bottom)
            make.width.equalTo(70)
            make.height.equalTo(25)
        }
    }
    
    var selectBtnClosure: (()->Void)?
    
    var goodsInfo: GoodsInfo = GoodsInfo() {
        didSet {
            ImgView.lc_setImage(with: goodsInfo.focusImgUrl)
            titleLab.text = goodsInfo.productName
            priceLab.text = "\(goodsInfo.salePrice)"
            discountLab.text = "\(goodsInfo.costPrice)"
            selectBtn.isSelected = goodsInfo.checked
        }
    }
    
    @objc func selectedAction() {
        selectBtnClosure?()
    }

}
