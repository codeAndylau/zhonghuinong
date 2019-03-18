//
//  PaySuccessView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/13.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class PaySuccessView: View {

    let titleLab = Label().then { (lab) in
        lab.text = "支付成功"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 18)
    }
    
    let cancelBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "basket_cancel"), for: .normal)
    }
    
    let centerImg = ImageView().then { (img) in
        img.image = UIImage(named: "basket_paySuccess")
    }
    
    let payLab = Label().then { (lab) in
        lab.text = "订单支付成功，准备打包发货"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let moneyLab = Label().then { (lab) in
        lab.text = "实付¥1188.0"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let otherView = View().then { (view) in
        view.backgroundColor = UIColor.white
        view.cuttingCorner(radius: 22)
        view.setupBorder(width: 1, color: UIColor.hexColor(0xDCDCDC))
    }
    
    let orderBtn = Button().then { (btn) in
        btn.setTitle("查看订单", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x9B9B9B), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xDCDCDC)
    }
    
    let continueBtn = Button().then { (btn) in
        btn.setTitle("继续逛逛", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x1DD1A8), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(cancelBtn)
        addSubview(centerImg)
        addSubview(payLab)
        addSubview(moneyLab)
        addSubview(otherView)
        
        otherView.addSubview(orderBtn)
        otherView.addSubview(lineView)
        otherView.addSubview(continueBtn)
    }

    override func updateUI() {
        super.updateUI()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.centerX.equalTo(self)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.centerY.equalTo(titleLab).offset(-10)
        }
        
        centerImg.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(33)
            make.centerX.equalTo(self)
        }
        
        payLab.snp.makeConstraints { (make) in
            make.top.equalTo(centerImg.snp.bottom).offset(11)
            make.centerX.equalTo(self)
        }
        
        moneyLab.snp.makeConstraints { (make) in
            make.top.equalTo(payLab.snp.bottom).offset(1)
            make.centerX.equalTo(self)
        }
        
        otherView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-40)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-120)
            make.height.equalTo(44)
        }
        
        orderBtn.snp.makeConstraints { (make) in
            make.left.centerY.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.center.height.equalToSuperview()
            make.width.equalTo(1)
        }
        
        continueBtn.snp.makeConstraints { (make) in
            make.right.centerY.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
    }
    
    /// - Public methods
    class func loadView() -> PaySuccessView {
        let view = PaySuccessView()
        view.frame = CGRect(x: 0, y: kScreenH*0.45, width: kScreenW, height: kScreenH*0.55)
        view.backgroundColor = Color.whiteColor
        let corners: UIRectCorner = [.topLeft, .topRight]
        view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }
    
}
