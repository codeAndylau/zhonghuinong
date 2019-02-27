//
//  MineNewProductTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/27.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import SnapKit

class MineNewProductTabCell: TableViewCell, TabReuseIdentifier {

    let contView = View().then { (view) in
        view.backgroundColor = Color.whiteColor
    }
    
    let topImg = ImageView().then { (img) in
        img.backgroundColor = Color.backdropColor
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "有机西兰花"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let detailLab = Label().then { (lab) in
        lab.text = "你吃你最想吃的啥擦即可擦看不出卡刷不出困境阿布贾擦拭科技传播卡结算 立即抢购"
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.numberOfLines = 0
    }
    
    let dateLab = Label().then { (lab) in
        lab.text = "15:20"
        lab.textColor = UIColor.white
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.backgroundColor = UIColor.hexColor(0xCCCCCC)
        lab.cuttingCorner(radius: 10)
    }
    
    var dateConstraint: Constraint?
    
    var model: String = "昨天15:20" {
        didSet {
            let dateWidth = getTextRectSize(text: model, font: dateLab.font, size: CGSize(width: kScreenW-30, height: 20)).width + 15
            dateConstraint?.update(offset: dateWidth)
            dateLab.text = model
        }
    }
    
    override func makeUI() {
        super.makeUI()
        
        addSubview(contView)
        contView.addSubview(topImg)
        contView.addSubview(titleLab)
        contView.addSubview(detailLab)
        
        addSubview(dateLab)
        
    }
    
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(12)
            make.right.equalTo(self).offset(-12)
            make.height.equalTo(220)
        }
        
        topImg.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(135)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(topImg.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(22)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        let dateWidth = getTextRectSize(text: dateLab.text!, font: dateLab.font, size: CGSize(width: kScreenW-30, height: 20)).width + 15
        
        dateLab.snp.makeConstraints { (make) in
            make.top.equalTo(contView.snp.bottom).offset(15)
            make.centerX.equalTo(self)
            self.dateConstraint = make.width.equalTo(dateWidth).constraint
            make.height.equalTo(20)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // shadowCode
        contView.layer.shadowColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.2).cgColor
        contView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contView.layer.shadowOpacity = 1
        contView.layer.shadowRadius = 5
        contView.layer.cornerRadius = 10
        
        // topImg
        let corners: UIRectCorner = [.topLeft, .topRight]
        topImg.cuttingAnyCorner(roundingCorners: corners, corner: 10)
    }

}
