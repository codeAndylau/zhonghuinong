//
//  DeliveryHeaderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 配送选货的headerView
class DeliveryHeaderView: View {

    lazy var addressView = OrderAddressView()
    lazy var dateView = DeliveryDateView()
    
    override func makeUI() {
        super.makeUI()
        addSubview(addressView)
        addSubview(dateView)
    }
    
    override func updateUI() {
        super.updateUI()
        
        addressView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(88)
        }
        
        dateView.snp.makeConstraints { (make) in
            make.top.equalTo(addressView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(50)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        dateView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        //        dateView.layer.shadowOffset = CGSize(width: 0, height: 4)
        //        dateView.layer.shadowOpacity = 1
        //        dateView.layer.shadowRadius = 6
    }

    /// - Public methods
    class func loadView() -> DeliveryHeaderView {
        let view = DeliveryHeaderView()
        view.frame = CGRect(x: 0, y: kNavBarH, width: kScreenW, height: 150)
        view.backgroundColor = Color.whiteColor
        //        let corners: UIRectCorner = [.bottomLeft, .bottomRight]
        //        view.dateView.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }
}
