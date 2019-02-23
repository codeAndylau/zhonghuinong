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
    }
    
    let peisongBtn = Button().then { (btn) in
        btn.setTitleColor(UIColor.hexColor(0x333333), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.adjustsImageWhenHighlighted = false
    }
    
    let shouhuoBtn = Button().then { (btn) in
        btn.setTitleColor(UIColor.hexColor(0x333333), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.adjustsImageWhenHighlighted = false
    }
    
    let orderBtn = Button().then { (btn) in
        btn.setTitleColor(UIColor.hexColor(0x333333), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.adjustsImageWhenHighlighted = false
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(orderLab)
        addSubview(fukuanBtn)
        addSubview(peisongBtn)
        addSubview(shouhuoBtn)
        addSubview(orderBtn)
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
        
        peisongBtn.snp.makeConstraints { (make) in
            make.left.equalTo(fukuanBtn.snp.right)
            make.centerY.equalTo(fukuanBtn)
            make.width.height.equalTo(fukuanBtn)
        }
        
        shouhuoBtn.snp.makeConstraints { (make) in
            make.left.equalTo(peisongBtn.snp.right)
            make.centerY.equalTo(peisongBtn)
            make.width.height.equalTo(peisongBtn)
        }
        
        orderBtn.snp.makeConstraints { (make) in
            make.left.equalTo(shouhuoBtn.snp.right)
            make.centerY.equalTo(shouhuoBtn)
            make.width.height.equalTo(shouhuoBtn)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // mine_peisong mine_shouhuo
        fukuanBtn.set(image: UIImage(named: "mine_fukuan"), title: "待付款", titlePosition: .bottom, additionalSpacing: 0, state: .normal)
        peisongBtn.set(image: UIImage(named: "mine_fukuan"), title: "待配送", titlePosition: .bottom, additionalSpacing: 0, state: .normal)
        shouhuoBtn.set(image: UIImage(named: "mine_order"), title: "待收货", titlePosition: .bottom, additionalSpacing: 0, state: .normal)
        orderBtn.set(image: UIImage(named: "mine_order"), title: "全部订单", titlePosition: .bottom, additionalSpacing: 0, state: .normal)
    }

    
}
