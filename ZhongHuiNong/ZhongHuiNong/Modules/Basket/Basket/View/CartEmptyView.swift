//
//  CartEmptyView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class CartEmptyView: View {

    let emptyImg = ImageView().then { (img) in
        img.image = UIImage(named: "basket_empty")
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "购物车空空如也"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let sureBtn = Button().then { (btn) in
        btn.setTitle("去逛逛", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.cuttingCorner(radius: 22)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(emptyImg)
        addSubview(titleLab)
        addSubview(sureBtn)
        activateConstraints()
    }

    func activateConstraints() {
        emptyImg.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(50)
            make.centerX.equalTo(self)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(emptyImg.snp.bottom).offset(30)
            make.centerX.equalTo(emptyImg)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(50)
            make.centerX.equalTo(titleLab)
            make.width.equalTo(kScreenW-100)
            make.height.equalTo(44)
        }
    }
    
    /// - Public methods
    class func loadView() -> CartEmptyView {
        let view = CartEmptyView()
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-kNavBarH-kTabBarH)
        view.backgroundColor = Color.whiteColor
        return view
    }
}


