//
//  DeliveryAddressModifyView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/19.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 地址修改
class DeliveryAddressModifyView: View {

    let titleLab = Label().then { (lab) in
        lab.text = "添加地址"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    let cancelBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "basket_cancel"), for: .normal)
    }
    
    let backBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "basket_cancel"), for: .normal)
    }
    
    let addressRowView = DeliveryRowView().then { (view) in
        view.titleLab.text = "地址"
        view.textTF.placeholder = "请填写地址"
    }
    
    let detailAddressRowView = DeliveryRowView().then { (view) in
        view.titleLab.text = "详细地址"
        view.textTF.placeholder = "详细地址例：1号楼1505"
        view.arrowImg.isHidden = true
    }
    
    let userRowView = DeliveryRowView().then { (view) in
        view.titleLab.text = "联系人"
        view.textTF.placeholder = "用于配送时对您的称呼"
        view.arrowImg.isHidden = true
    }
    
    let phoneRowView = DeliveryRowView().then { (view) in
        view.titleLab.text = "手机号"
        view.textTF.placeholder = "用于配送时对您的称呼"
        view.textTF.keyboardType = .numberPad
        view.arrowImg.isHidden = true
    }
    
    let selectBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "basket_cancel"), for: .normal)
    }
    
    let tipLab = Label().then { (lab) in
        lab.text = "设为默认地址"
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 16)
    }
    
    let sureBtn = Button().then { (btn) in
        btn.setTitle("确认", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.cuttingCorner(radius: 22)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(cancelBtn)
        addSubview(backBtn)
        addSubview(addressRowView)
        addSubview(detailAddressRowView)
        addSubview(userRowView)
        addSubview(phoneRowView)
        addSubview(selectBtn)
        addSubview(tipLab)
        addSubview(sureBtn)
        
    }
    
    override func updateUI() {
        super.updateUI()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
        }
        
        backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(titleLab)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.centerY.equalTo(titleLab)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).inset(40)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-100)
            make.height.equalTo(44)
        }
        
        addressRowView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(50)
            make.left.right.equalTo(self)
            make.height.equalTo(50)
        }
        
        detailAddressRowView.snp.makeConstraints { (make) in
            make.top.equalTo(addressRowView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(50)
        }
        
        userRowView.snp.makeConstraints { (make) in
            make.top.equalTo(detailAddressRowView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(50)
        }
        
        phoneRowView.snp.makeConstraints { (make) in
            make.top.equalTo(userRowView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(50)
        }
        
        tipLab.snp.makeConstraints { (make) in
            make.top.equalTo(phoneRowView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
        
        selectBtn.snp.makeConstraints { (make) in
            make.right.equalTo(tipLab.snp.left).offset(5)
            make.centerY.equalTo(tipLab)
        }
    }

    
    /// - Public methods
    class func loadView() -> DeliveryAddressModifyView {
        let view = DeliveryAddressModifyView()
        view.frame = CGRect(x: 0, y: kScreenH*0.45, width: kScreenW, height: kScreenH*0.55)
        view.backgroundColor = Color.whiteColor
        let corners: UIRectCorner = [.topLeft, .topRight]
        view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }
    
}
