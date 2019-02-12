//
//  PaySelectView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class PaySelectView: View {

    let titleLab = Label().then { (lab) in
        lab.text = "需支付："
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 18)
    }
    
    let moneyLab = Label().then { (lab) in
        lab.text = "¥1188.90"
        lab.textColor = UIColor.hexColor(0x1DD1A8)
        lab.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    let cancelBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "basket_cancel"), for: .normal)
    }
    
    let bagView = View().then { (view) in
        view.backgroundColor = UIColor.white
    }
    
    let bagImg = ImageView().then { (img) in
        img.image = UIImage(named: "basket_bag")
    }
    
    let bagLab = Label().then { (lab) in
        lab.text = "卡包余额"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let balanceLab = Label().then { (lab) in
        lab.text = "可用余额0元"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let otherLab = Label().then { (lab) in
        lab.text = "其它方式支付"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let otherView = View().then { (view) in
        view.backgroundColor = UIColor.white
    }
    
    let wechatImg = ImageView().then { (img) in
        img.image = UIImage(named: "basket_wechat")
    }
    
    let wechatLab = Label().then { (lab) in
        lab.text = "卡包余额"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let alipayImg = ImageView().then { (img) in
        img.image = UIImage(named: "basket_ailpay")
    }
    
    let alipayLab = Label().then { (lab) in
        lab.text = "卡包余额"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    override func makeUI() {
        super.makeUI()
    }
    
    override func updateUI() {
        super.updateUI()
    }
    
    

}
