//
//  OrderHeaderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class OrderHeaderView: View {

    lazy var addressView = OrderAddressView()
    lazy var payView = View()
    let titleLab = Label().then { (lab) in
        lab.text = "支付方式"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let payLab = Label().then { (lab) in
        lab.text = "卡包扣付"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let selectBtn: Button = {
        let btn = Button(type: UIButton.ButtonType.custom)
        return btn
    }()
    
    override func makeUI() {
        super.makeUI()
        addSubview(addressView)
        addSubview(payView)
        payView.addSubview(titleLab)
        payView.addSubview(payLab)
        payView.addSubview(selectBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        
        addressView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(7)
            make.centerX.equalToSuperview()
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(97)
        }
        
        payView.snp.makeConstraints { (make) in
            make.top.equalTo(addressView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(44)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(payView.snp.left).offset(15)
            make.centerY.equalToSuperview()
        }

        payLab.snp.makeConstraints { (make) in
            make.right.equalTo(payView).offset(-15)
            make.centerY.equalToSuperview()
        }

        selectBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addressView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
        addressView.layer.shadowOffset = CGSize(width: 0, height: 0)
        addressView.layer.shadowOpacity = 1
        addressView.layer.shadowRadius = 6
        addressView.layer.cornerRadius = 12
        
        payView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
        payView.layer.shadowOffset = CGSize(width: 0, height: 0)
        payView.layer.shadowOpacity = 1
        payView.layer.shadowRadius = 6
        payView.layer.cornerRadius = 12
    }
    
    /// - Public methods
    class func loadView() -> OrderHeaderView {
        let view = OrderHeaderView()
        view.frame = CGRect(x: 0, y: 10, width: kScreenW, height: 170)
        view.backgroundColor = Color.backdropColor
        return view
    }

}
