//
//  PaySelectView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

enum PaySelectViewType { case bag, wechat, alipay }

class PaySelectView: View {

    let titleLab = Label().then { (lab) in
        lab.text = "需支付："
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 18)
    }
    
    let moneyLab = Label().then { (lab) in
        lab.text = "¥0.0"
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
    
    let bagSelectBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "mine_order_unselected"), for: .normal)
        btn.setImage(UIImage(named: "mine_order_selected"), for: .selected)
        btn.isSelected = true
    }
    
    let otherLab = Label().then { (lab) in
        lab.text = "其它方式支付(暂不支持)"
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
        lab.text = "微信支付"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 14)
    }

    let wechatSelectBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "mine_order_unselected"), for: .normal)
        btn.setImage(UIImage(named: "mine_order_disabled"), for: .disabled)
        btn.isEnabled = false
    }
    
    let alipayImg = ImageView().then { (img) in
        img.image = UIImage(named: "basket_ailpay")
    }
    
    let alipayLab = Label().then { (lab) in
        lab.text = "支付宝支付"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let alipaySelectBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "mine_order_unselected"), for: .normal)
        btn.setImage(UIImage(named: "mine_order_disabled"), for: .disabled)
        btn.isEnabled = false
    }
    
    let sureBtn = Button().then { (btn) in
        btn.setTitle("余额支付", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.cuttingCorner(radius: 22)
    }
    
    var status: PaySelectViewType = .bag {
        didSet {
            switch status {
            case .bag:
                bagSelectBtn.setImage(UIImage(named: "mine_order_selected"), for: .normal)
                wechatSelectBtn.setImage(UIImage(named: "mine_order_unselected"), for: .normal)
                alipaySelectBtn.setImage(UIImage(named: "mine_order_unselected"), for: .normal)
            case .wechat:
                bagSelectBtn.setImage(UIImage(named: "mine_order_unselected"), for: .normal)
                wechatSelectBtn.setImage(UIImage(named: "mine_order_selected"), for: .normal)
                alipaySelectBtn.setImage(UIImage(named: "mine_order_unselected"), for: .normal)
            case .alipay:
                bagSelectBtn.setImage(UIImage(named: "mine_order_unselected"), for: .normal)
                wechatSelectBtn.setImage(UIImage(named: "mine_order_unselected"), for: .normal)
                alipaySelectBtn.setImage(UIImage(named: "mine_order_selected"), for: .normal)
            }
        }
    }

    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(moneyLab)
        addSubview(cancelBtn)
        addSubview(bagView)
        
        bagView.addSubview(bagImg)
        bagView.addSubview(bagLab)
        bagView.addSubview(balanceLab)
        bagView.addSubview(bagSelectBtn)
        
        addSubview(otherLab)
        addSubview(otherView)
        
        otherView.addSubview(wechatImg)
        otherView.addSubview(wechatLab)
        otherView.addSubview(wechatSelectBtn)
        otherView.addSubview(alipayImg)
        otherView.addSubview(alipayLab)
        otherView.addSubview(alipaySelectBtn)
        
        addSubview(sureBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).offset(15)
        }
        
        moneyLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right)
            make.centerY.equalTo(titleLab)
            make.right.lessThanOrEqualTo(cancelBtn.snp.left).offset(15)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.centerY.equalTo(titleLab).offset(-10)
        }
        
        bagView.snp.makeConstraints { (make) in
            make.top.equalTo(moneyLab.snp.bottom).offset(18)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(56)
        }
        
        bagImg.snp.makeConstraints { (make) in
            make.left.centerY.equalToSuperview()
            make.width.height.equalTo(56)
        }
        
        bagLab.snp.makeConstraints { (make) in
            make.left.equalTo(bagImg.snp.right)
            make.centerY.equalToSuperview()
        }
        
        bagSelectBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(56)
        }
        
        balanceLab.snp.makeConstraints { (make) in
            make.right.equalTo(bagSelectBtn.snp.left)
            make.centerY.equalToSuperview()
        }
        
        otherLab.snp.makeConstraints { (make) in
            make.top.equalTo(bagView.snp.bottom).offset(20)
            make.left.equalTo(self).offset(15)
        }
        
        otherView.snp.makeConstraints { (make) in
            make.top.equalTo(otherLab.snp.bottom).offset(5)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(112)
        }
        
        wechatImg.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.height.equalTo(56)
        }
        
        wechatLab.snp.makeConstraints { (make) in
            make.left.equalTo(wechatImg.snp.right)
            make.centerY.equalTo(wechatImg)
        }
        
        wechatSelectBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalTo(wechatImg)
            make.width.height.equalTo(56)
        }
        
        alipayImg.snp.makeConstraints { (make) in
            make.top.equalTo(wechatImg.snp.bottom)
            make.left.equalToSuperview()
            make.height.equalTo(56)
        }
        
        alipayLab.snp.makeConstraints { (make) in
            make.left.equalTo(alipayImg.snp.right)
            make.centerY.equalTo(alipayImg)
        }
        
        alipaySelectBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalTo(alipayImg)
            make.width.height.equalTo(56)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-40)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-120)
            make.height.equalTo(44)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // shadowCode
        bagView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
        bagView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bagView.layer.shadowOpacity = 1
        bagView.layer.shadowRadius = 6
        bagView.layer.cornerRadius = 12
        
        otherView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
        otherView.layer.shadowOffset = CGSize(width: 0, height: 0)
        otherView.layer.shadowOpacity = 1
        otherView.layer.shadowRadius = 6
        otherView.layer.cornerRadius = 12
    }
    
    /// - Public methods
    class func loadView() -> PaySelectView {
        let view = PaySelectView()
        view.frame = CGRect(x: 0, y: kScreenH*0.45, width: kScreenW, height: kScreenH*0.55)
        view.backgroundColor = Color.whiteColor
        let corners: UIRectCorner = [.topLeft, .topRight]
        view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }

}
