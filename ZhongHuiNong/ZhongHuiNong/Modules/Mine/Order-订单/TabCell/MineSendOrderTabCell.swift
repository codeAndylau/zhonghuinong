//
//  MineSendOrderTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineSendOrderTabCell: MinePayOrderTabCell {

    override func makeUI() {
        selectionStyle = .none
        backgroundColor = UIColor.hexColor(0xFAFAFA)
        statusLab.text = "买家已付款"
        cancelBtn.setTitle("修改地址", for: .normal)
        
        addSubview(contView)
        contView.addSubview(titleLab)
        contView.addSubview(arrowImg)
        contView.addSubview(statusLab)
        contView.addSubview(vegetablesView)
        contView.addSubview(cancelBtn)
        contView.addSubview(moneyLab)
        contView.addSubview(tipsLab)
        contView.addSubview(numLab)
    }
    
    override func updateUI() {
        
        contView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 10, left: 12, bottom: 0, right: 12))
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(12)
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right).offset(6)
            make.centerY.equalTo(titleLab)
        }
        
        statusLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        vegetablesView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(50)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
            make.width.equalTo(78)
            make.height.equalTo(30)
        }
        
        moneyLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalTo(cancelBtn.snp.top).offset(-15)
        }
        
        tipsLab.snp.makeConstraints { (make) in
            make.right.equalTo(moneyLab.snp.left)
            make.centerY.equalTo(moneyLab)
        }
        
        numLab.snp.makeConstraints { (make) in
            make.right.equalTo(tipsLab.snp.left).offset(-6)
            make.centerY.equalTo(tipsLab)
        }
    }
    
    var sendOrder: MineGoodsOrderInfo = MineGoodsOrderInfo() {
        didSet {
            
            statusLab.text = "等待商家发货"
            
            numLab.text = "\(sendOrder.orderGoodsList.count)"
            
            var price: CGFloat = 0
            sendOrder.orderGoodsList.forEach { (item) in
                price += item.goodsPrice * CGFloat(item.quantity)
            }
            
            moneyLab.text = "\(price)"
        }
    }

}
