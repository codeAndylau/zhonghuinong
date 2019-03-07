//
//  MineAddressDefaultView.swift
//  ZhongHuiNong
//
//  Created by lau Andy on 2019/3/7.
//  Copyright © 2019年 Andylau. All rights reserved.
//

import UIKit

class MineAddressDefaultView: View {

    var isDefault: Bool = true {
        didSet {
            if isDefault {
                selectBtn.setImage(UIImage(named: "mine_order_selected"), for: .normal)
            }else {
                selectBtn.setImage(UIImage(named: "mine_order_unselected"), for: .normal)
            }
        }
    }
    
    let selectBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "mine_order_selected"), for: .normal)
    }
    
    let tipLab = Label().then { (lab) in
        lab.text = "设为默认地址"
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    override func makeUI() {
        addSubview(selectBtn)
        selectBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-50)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        addSubview(tipLab)
        tipLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(selectBtn)
            make.left.equalTo(selectBtn.snp.right).offset(-10)
        }
    }
    
    /// Public method
    
    class func loadView() -> MineAddressDefaultView {
        let view = MineAddressDefaultView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 50))
        return view
    }
}
