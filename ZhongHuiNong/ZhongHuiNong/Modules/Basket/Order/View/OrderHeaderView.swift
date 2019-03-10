//
//  OrderHeaderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class OrderHeaderView: View {
    
    var addressInfo: UserAddressInfo = UserAddressInfo() {
        didSet {
            // 还没有地址
            if addressInfo.id == defaultId {
                addressView.tipLab.isHidden = false
            }else {
                addressView.nameLab.text = addressInfo.linkMan
                addressView.phoneLab.text = addressInfo.mobile
                addressView.addressLab.text = addressInfo.preaddress+addressInfo.address
            }
        }
    }
    
    lazy var addressView = OrderAddressView()
    
    override func makeUI() {
        super.makeUI()
        addSubview(addressView)
    }
    
    override func updateUI() {
        super.updateUI()
        addressView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(97)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addressView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
        addressView.layer.shadowOffset = CGSize(width: 0, height: 0)
        addressView.layer.shadowOpacity = 1
        addressView.layer.shadowRadius = 6
        addressView.layer.cornerRadius = 12
    }
    
    /// - Public methods
    class func loadView() -> OrderHeaderView {
        let view = OrderHeaderView()
        view.frame = CGRect(x: 0, y: 10, width: kScreenW, height: 115)
        view.backgroundColor = Color.backdropColor
        return view
    }
    
}
