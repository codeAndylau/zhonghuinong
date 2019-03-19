//
//  MineCancelOrderTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/19.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineCancelOrderTabCell: MineOrderTabCell {
    
    let leftView = View().then { (view) in
        view.backgroundColor = UIColor.white
    }

    let cancelBtn = Button().then { (btn) in
        btn.setTitle("删除订单", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setupBorder(width: 1, color: UIColor.hexColor(0x999999))
        btn.cuttingCorner(radius: 15)
        
    }
    
    /// 1 是取消 2 是支付
    var btnActionClosure:(()->Void)?
    
    @objc func cancelBtnAction() {
        btnActionClosure?()
    }
    
    override func makeUI() {
        
        selectionStyle = .none
        backgroundColor = UIColor.hexColor(0xFAFAFA)
        statusLab.text = "等待付款"
        addSubview(contView)
        contView.addSubview(leftView)
        contView.addSubview(titleLab)
        contView.addSubview(arrowImg)
        contView.addSubview(statusLab)
        contView.addSubview(timeLab)
        contView.addSubview(vegetablesView)
        contView.addSubview(moneyLab)
        contView.addSubview(tipsLab)
        contView.addSubview(numLab)
        contView.addSubview(cancelBtn)
        
        cancelBtn.addTarget(self, action: #selector(cancelBtnAction), for: UIControl.Event.touchUpInside)
    }
    
    override func updateUI() {
        
        contView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 10, left: 12, bottom: 0, right: 12))
        }
        
        leftView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(8)
            make.width.height.equalTo(30)
        }

        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalTo(leftView)
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right).offset(6)
            make.centerY.equalTo(titleLab)
        }
        
        statusLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.right.equalTo(statusLab.snp.left).offset(-10)
            make.centerY.equalTo(statusLab)
        }
        
        vegetablesView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
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
            make.bottom.equalTo(cancelBtn.snp.top).offset(-10)
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
    
    var payOrder: MineGoodsOrderInfo = MineGoodsOrderInfo() {
        didSet {
            
            numLab.text = "共\(payOrder.orderGoodsList.count)件"
            
            if payOrder.add_time.components(separatedBy: "T").count > 1 {
                timeLab.text = payOrder.add_time.components(separatedBy: "T")[0]
            }else {
                timeLab.text = payOrder.add_time
            }
            
            for item in payOrder.orderGoodsList.enumerated() {
                
                debugPrints("待支付商品图片信息---\(item.element.goodsPic)")
                
                vegetablesView.btn1.image = UIImage()
                vegetablesView.btn2.image = UIImage()
                vegetablesView.btn3.image = UIImage()
                vegetablesView.btn4.image = UIImage()
                vegetablesView.btn5.image = UIImage()
                
                if item.offset == 0 {
                    vegetablesView.btn1.lc_setImage(with: item.element.goodsPic)
                }
                
                if item.offset == 1 {
                    vegetablesView.btn2.lc_setImage(with: item.element.goodsPic)
                }
                
                if item.offset == 2 {
                    vegetablesView.btn3.lc_setImage(with: item.element.goodsPic)
                }
                
                if item.offset == 3 {
                    vegetablesView.btn4.lc_setImage(with: item.element.goodsPic)
                }
                
                if item.offset == 4 {
                    vegetablesView.btn5.lc_setLocalImage(with: "mine_order_omit")
                }
                
            }
            
            moneyLab.text = "\(payOrder.amountReal)"
        }
    }
    
}
