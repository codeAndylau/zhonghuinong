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
    
    // 加减号购物
    lazy var calculateView: View = {
        let v = View()
        return v
    }()
    
    lazy var jiahaoBtn: Button = {
        let btn = Button(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "store_jiahao"), for: .normal)
        return btn
    }()
    
    lazy var jianhaoBtn: Button = {
        let btn = Button(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "store_jianhao"), for: .normal)
        return btn
    }()
    
    lazy var numLab: Label = {
        let lab = Label()
        lab.textAlignment = .center
        lab.text = "1"
        return lab
    }()
    
    override func makeUI() {
        super.makeUI()
        addSubview(ImgView)
        addSubview(titleLab)
        addSubview(priceLab)
        addSubview(discountLab)
        addSubview(calculateView)
        
        calculateView.addSubview(jianhaoBtn)
        calculateView.addSubview(numLab)
        calculateView.addSubview(jiahaoBtn)
        
        ImgView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
            make.width.height.equalTo(90)
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
    
    override func updateUI() {
        super.updateUI()
    }
    
}
