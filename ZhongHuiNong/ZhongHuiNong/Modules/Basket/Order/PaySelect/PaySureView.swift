//
//  PaySureView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/13.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class PaySureView: View {

    let contView = View()
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xE5E5E5)
    }
    
    let moneyLab = Label().then { (lab) in
        lab.text = "¥388.0"
        lab.textColor = UIColor.hexColor(0x1DD1A8)
        lab.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    let priceLab = Label().then { (lab) in
        lab.text = "已优惠¥800.0"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let numLab = Label().then { (lab) in
        lab.text = "共8件"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    let sureBtn = Button().then { (btn) in
        btn.setTitle("确认支付", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(contView)
        contView.addSubview(lineView)
        contView.addSubview(moneyLab)
        contView.addSubview(priceLab)
        contView.addSubview(numLab)
        contView.addSubview(sureBtn)
    }

    
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(56)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        moneyLab.snp.makeConstraints { (make) in
            make.left.equalTo(contView).offset(16)
            make.centerY.equalTo(contView)
        }
        
        priceLab.snp.makeConstraints { (make) in
            make.left.equalTo(moneyLab.snp.right).offset(20)
            make.centerY.equalTo(contView)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.right.equalTo(contView).offset(-16)
            make.centerY.equalTo(contView)
            make.width.equalTo(90)
            make.height.equalTo(40)
        }
        
        numLab.snp.makeConstraints { (make) in
            make.right.equalTo(sureBtn.snp.left).offset(-8)
            make.centerY.equalTo(contView)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // shadowCode
        sureBtn.layer.shadowColor = UIColor(red: 0.11, green: 0.82, blue: 0.66, alpha: 0.5).cgColor
        sureBtn.layer.shadowOffset = CGSize(width: 0, height: 3)
        sureBtn.layer.shadowOpacity = 1
        sureBtn.layer.shadowRadius = 5
        sureBtn.layer.cornerRadius = 20
    }
    
    
    /// - Public methods
    class func loadView() -> PaySureView {
        let view = PaySureView()
        let viewH: CGFloat = IPhone_X == true ? 90 : 56
        view.frame = CGRect(x: 0, y: kScreenH-kNavBarH-viewH, width: kScreenW, height: viewH)
        view.backgroundColor = Color.whiteColor
        return view
    }
}
