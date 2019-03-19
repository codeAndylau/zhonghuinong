//
//  DeliveryOrderInfoTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/20.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryOrderInfoTabCell: TableViewCell, TabReuseIdentifier {

    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xFAFAFA)
    }
    
    let weekLab = Label().then { (lab) in
        lab.text = "星期二"
        lab.textColor = UIColor.hexColor(0x524C4A)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let finishLab = Label().then { (lab) in
        lab.text = "已完成"
        lab.textColor = UIColor.hexColor(0x524C4A)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let dateLab = Label().then { (lab) in
        lab.text = "2019-02-11 12:20"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let vegetablesView = VegetablesView()
    
    let totalLab = Label().then { (lab) in
        lab.text = "8.5kg"
        lab.textColor = UIColor.hexColor(0x1DD1A8)
        lab.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let numLab = Label().then { (lab) in
        lab.text = ""
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(weekLab)
        addSubview(finishLab)
        addSubview(dateLab)
        addSubview(vegetablesView)
        addSubview(totalLab)
        addSubview(numLab)
        addSubview(lineView)
    }

    override func updateUI() {
        super.updateUI()
        
        weekLab.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self).offset(15)
        }

        dateLab.snp.makeConstraints { (make) in
            make.top.equalTo(weekLab.snp.bottom)
            make.left.equalTo(weekLab)
        }
        
        finishLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(dateLab)
            make.right.equalTo(self).offset(-15)
        }
        
        vegetablesView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(dateLab.snp.bottom).offset(20)
            make.width.equalTo(kScreenW-100)
            make.height.equalTo(44)
        }
        
        totalLab.snp.makeConstraints { (make) in
            make.top.equalTo(vegetablesView)
            make.right.equalTo(self).offset(-15)
        }
        
        numLab.snp.makeConstraints { (make) in
            make.top.equalTo(totalLab.snp.bottom)
            make.right.equalTo(totalLab)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(10)
        }
    }
    
    var info: DispatchVegetablesInfo = DispatchVegetablesInfo() {
        didSet {
            
            weekLab.text = info.scheduleDay
            
            dateLab.text = info.createdat.replacingOccurrences(of: "T", with: " ")
            
            totalLab.text = Keepfigures(text: CGFloat(info.weight))
            numLab.text = "共\(info.dispatchOrderDetail.count)件"
            
            for item in info.dispatchOrderDetail.enumerated() {
                
                debugPrints("商品图片信息---\(item.element.focusImgUrl)")
                
                if item.offset == 0 {
                    vegetablesView.btn1.lc_setImage(with: item.element.focusImgUrl)
                }
                
                if item.offset == 1 {
                    vegetablesView.btn2.lc_setImage(with: item.element.focusImgUrl)
                }
                
                if item.offset == 2 {
                    vegetablesView.btn3.lc_setImage(with: item.element.focusImgUrl)
                }
                
                if item.offset == 3 {
                    vegetablesView.btn4.lc_setImage(with: item.element.focusImgUrl)
                }
                
                if item.offset == 4 {
                    vegetablesView.btn5.lc_setLocalImage(with: "mine_order_omit")
                }
                
            }
        }
    }
    
}
