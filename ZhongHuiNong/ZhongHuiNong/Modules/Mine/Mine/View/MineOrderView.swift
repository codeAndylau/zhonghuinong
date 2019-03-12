//
//  MineOrderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineOrderView: View {
    
    let orderLab = Label().then { (lab) in
        lab.text = "我的订单"
        lab.textColor = UIColor.hexColor(0x524C4A)
        lab.textAlignment = .left
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let fukuanBtn = Button().then { (btn) in
        btn.setTitleColor(UIColor.hexColor(0x333333), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.adjustsImageWhenHighlighted = false
        btn.lc_setLocalImage(with: "mine_order")
    }
    
    let fukuanLab = Label().then { (lab) in
        lab.text =  "全部订单"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.textAlignment = .left
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let peisongBtn = Button().then { (btn) in
        btn.setTitleColor(UIColor.hexColor(0x333333), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.adjustsImageWhenHighlighted = false
        btn.lc_setLocalImage(with: "mine_fukuan")
    }
    
    let peisongLab = Label().then { (lab) in
        lab.text = "待付款"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.textAlignment = .left
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let shouhuoBtn = Button().then { (btn) in
        btn.setTitleColor(UIColor.hexColor(0x333333), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.adjustsImageWhenHighlighted = false
        btn.lc_setLocalImage(with: "mine_peisong") 
    }
    
    let shouhuoLab = Label().then { (lab) in
        lab.text = "待配送"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.textAlignment = .left
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let orderBtn = Button().then { (btn) in
        btn.setTitleColor(UIColor.hexColor(0x333333), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.adjustsImageWhenHighlighted = false
        btn.lc_setLocalImage(with: "mine_shouhuo")
    }
    
    let allOrderLab = Label().then { (lab) in
        lab.text = "待收货"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.textAlignment = .left
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(orderLab)
        addSubview(fukuanBtn)
        addSubview(peisongBtn)
        addSubview(shouhuoBtn)
        addSubview(orderBtn)
        
        fukuanBtn.addSubview(fukuanLab)
        peisongBtn.addSubview(peisongLab)
        shouhuoBtn.addSubview(shouhuoLab)
        orderBtn.addSubview(allOrderLab)
        activateConstraints()
    }
    
    func activateConstraints() {
        
        orderLab.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(15)
            make.height.equalTo(20)
        }
        
        fukuanBtn.snp.makeConstraints { (make) in
            make.top.equalTo(orderLab.snp.bottom)
            make.left.equalTo(self)
            make.width.equalTo((kScreenW-30)/4)
            make.height.equalTo(80)
        }
        
        fukuanLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(fukuanBtn.snp.bottom)
            make.centerX.equalTo(fukuanBtn)
        }
        
        peisongBtn.snp.makeConstraints { (make) in
            make.left.equalTo(fukuanBtn.snp.right)
            make.centerY.equalTo(fukuanBtn)
            make.width.height.equalTo(fukuanBtn)
        }
        
        peisongLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(peisongBtn.snp.bottom)
            make.centerX.equalTo(peisongBtn)
        }
        
        shouhuoBtn.snp.makeConstraints { (make) in
            make.left.equalTo(peisongBtn.snp.right)
            make.centerY.equalTo(peisongBtn)
            make.width.height.equalTo(peisongBtn)
        }
        
        shouhuoLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(shouhuoBtn.snp.bottom)
            make.centerX.equalTo(shouhuoBtn)
        }
        
        orderBtn.snp.makeConstraints { (make) in
            make.left.equalTo(shouhuoBtn.snp.right)
            make.centerY.equalTo(shouhuoBtn)
            make.width.height.equalTo(shouhuoBtn)
        }
        
        allOrderLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(orderBtn.snp.bottom)
            make.centerX.equalTo(orderBtn)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        fukuanBtn.set(image: UIImage(named: "mine_fukuan"), title: "待付款", titlePosition: .bottom, additionalSpacing: 0, state: .normal)
//        peisongBtn.set(image: UIImage(named: "mine_peisong"), title: "待配送", titlePosition: .bottom, additionalSpacing: 0, state: .normal)
//        shouhuoBtn.set(image: UIImage(named: "mine_shouhuo"), title: "待收货", titlePosition: .bottom, additionalSpacing: 0, state: .normal)
//        orderBtn.set(image: UIImage(named: "mine_order"), title: "全部订单", titlePosition: .bottom, additionalSpacing: 0, state: .normal)
    }

    
}
