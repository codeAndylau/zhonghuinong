//
//  MineAcceptOrderTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineAcceptOrderTabCell: MinePayOrderTabCell {
    
    override func makeUI() {
        
        selectionStyle = .none
        backgroundColor = UIColor.hexColor(0xFAFAFA)
        statusLab.text = "已发货"
        cancelBtn.setTitle("查看物流", for: .normal)
        payBtn.setTitle("确认收货", for: .normal)
        
        addSubview(contView)
        contView.addSubview(titleLab)
        contView.addSubview(arrowImg)
        contView.addSubview(statusLab)
        contView.addSubview(timeLab)
        contView.addSubview(vegetablesView)
        contView.addSubview(payBtn)
        contView.addSubview(cancelBtn)
        contView.addSubview(moneyLab)
        contView.addSubview(tipsLab)
        contView.addSubview(numLab)
        
        cancelBtn.addTarget(self, action: #selector(AcceptCancelBtnAction), for: UIControl.Event.touchUpInside)
        payBtn.addTarget(self, action: #selector(AcceptPayBtnAction), for: UIControl.Event.touchUpInside)
    }
    
    /// 1 是取消 2 是支付
    var AcceptBtnActionClosure:((_ index: Int)->Void)?
    
    @objc func AcceptCancelBtnAction() {
        AcceptBtnActionClosure?(1)
    }
    
    @objc func AcceptPayBtnAction() {
        AcceptBtnActionClosure?(2)
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
        
        payBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
            make.width.equalTo(78)
            make.height.equalTo(30)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalTo(payBtn.snp.left).offset(-12)
            make.centerY.equalTo(payBtn)
            make.width.equalTo(78)
            make.height.equalTo(30)
        }
        
        moneyLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalTo(payBtn.snp.top).offset(-10)
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
    
    var acceptOrder: MineGoodsOrderInfo = MineGoodsOrderInfo() {
        didSet {
            
            numLab.text = "共\(acceptOrder.orderGoodsList.count)件"
            
            if acceptOrder.add_time.components(separatedBy: "T").count > 1 {
                timeLab.text = acceptOrder.add_time.components(separatedBy: "T")[0]
            }else {
                timeLab.text = acceptOrder.add_time
            }
            
            for item in acceptOrder.orderGoodsList.enumerated() {
                
                debugPrints("待收货商品图片信息---\(item.element.goodsPic)")
                
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
            moneyLab.text = "\(acceptOrder.amountReal)"
        }
    }
    
}
