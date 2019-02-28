//
//  StoreFilterView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/28.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class StoreFilterView: View {
    
    let numBtn = Button().then { (btn) in
        btn.setTitle("销量", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let priceBtn = Button().then { (btn) in
        btn.setTitleColor(UIColor.hexColor(0x1DD1A8), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }

    override func makeUI() {
        super.makeUI()
        addSubview(numBtn)
        addSubview(priceBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        priceBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
            make.width.height.equalTo(44)
        }
        numBtn.snp.makeConstraints { (make) in
            make.right.equalTo(priceBtn.snp.left)
            make.centerY.equalTo(self)
            make.width.height.equalTo(44)
        }
    }
    
    override func layoutSubviews() {
        priceBtn.set(image: UIImage(named: "farm_arrow_left"), title: "价格", titlePosition: .left, additionalSpacing: 0, state: .normal)
    }
    
    /// Public method
    
    class func loadView() -> StoreFilterView {
        let view = StoreFilterView(frame: CGRect(x: 88, y: kNavBarH, width: kScreenW-88, height: 44))
        return view
    }
    

}
