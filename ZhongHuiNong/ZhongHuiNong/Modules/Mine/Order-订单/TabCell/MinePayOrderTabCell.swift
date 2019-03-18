//
//  MinePayOrderTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MinePayOrderTabCell: MineOrderTabCell {

    let leftView = View().then { (view) in
        view.backgroundColor = UIColor.white
    }
    
    let leftImg = ImageView().then { (img) in
        img.image = UIImage(named: "mine_order_selected")
    }
    
    let cancelBtn = Button().then { (btn) in
        btn.setTitle("取消订单", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setupBorder(width: 1, color: UIColor.hexColor(0x999999))
        btn.cuttingCorner(radius: 15)
        
    }
    
    let payBtn = Button().then { (btn) in
        btn.setTitle("立即支付", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x1DD1A8), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setupBorder(width: 1, color: UIColor.hexColor(0x1DD1A8))
        btn.cuttingCorner(radius: 15)
    }
    
    /// 1 是取消 2 是支付
    var btnActionClosure:((_ index: Int)->Void)?
    
    @objc func cancelBtnAction() {
        btnActionClosure?(1)
    }
    
    @objc func payBtnAction() {
        btnActionClosure?(2)
    }
    
    override func makeUI() {
        selectionStyle = .none
        backgroundColor = UIColor.hexColor(0xFAFAFA)
        statusLab.text = "等待付款"
        addSubview(contView)
        contView.addSubview(leftView)
        leftView.addSubview(leftImg)
        contView.addSubview(titleLab)
        contView.addSubview(arrowImg)
        contView.addSubview(statusLab)
        contView.addSubview(vegetablesView)
        contView.addSubview(moneyLab)
        contView.addSubview(tipsLab)
        contView.addSubview(numLab)
        contView.addSubview(cancelBtn)
        contView.addSubview(payBtn)
        
        cancelBtn.addTarget(self, action: #selector(cancelBtnAction), for: UIControl.Event.touchUpInside)
        payBtn.addTarget(self, action: #selector(payBtnAction), for: UIControl.Event.touchUpInside)
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
        
        leftImg.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(leftView.snp.right).offset(2)
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
    
    var payOrder: MineGoodsOrderInfo = MineGoodsOrderInfo() {
        didSet {
            
            numLab.text = "共\(payOrder.orderGoodsList.count)件"
            
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
