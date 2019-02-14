//
//  CartSectionHeaderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class CartSectionHeaderView: View {

    lazy var titleLab = Label().then { (lab) in
        lab.text = "共1件商品"
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.textColor = UIColor.hexColor(0x4A4A4A)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
    }
    
    override func updateUI() {
        super.updateUI()
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalTo(self)
        }
    }

    /// - Public methods
    class func loadView() -> CartSectionHeaderView {
        let view = CartSectionHeaderView()
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 20)
        view.backgroundColor = Color.whiteColor
        return view
    }
    
    class func loadOtherView() -> CartSectionHeaderView {
        let view = CartSectionHeaderView()
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 50)
        view.backgroundColor = Color.whiteColor
        view.titleLab.font = UIFont.boldSystemFont(ofSize: 18)
        view.titleLab.textColor = UIColor.hexColor(0x333333)
        return view
    }
    
}
