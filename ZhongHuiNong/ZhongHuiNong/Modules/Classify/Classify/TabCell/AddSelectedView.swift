//
//  AddSelectedView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 购物车加减选择试图--- 80 - 30
class AddSelectedView: View {

    lazy var jiahaoBtn: Button = {
        let btn = Button(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "store_jiahao"), for: .normal)
        return btn
    }()
    
    lazy var numLab: Label = {
        let lab = Label()
        lab.text = "1"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 12)
        return lab
    }()
    
    lazy var jianhaoBtn: Button = {
        let btn = Button(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "store_jianhao"), for: .normal)
        return btn
    }()

    override func makeUI() {
        super.makeUI()
        addSubview(jiahaoBtn)
        addSubview(numLab)
        addSubview(jianhaoBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        jianhaoBtn.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(self)
            make.width.height.equalTo(27)
        }
        
        numLab.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.height.equalTo(20)
        }
        
        jiahaoBtn.snp.makeConstraints { (make) in
            make.right.centerY.equalTo(self)
            make.width.height.equalTo(27)
        }
    }

    class func loadView() -> AddSelectedView {
        let view = AddSelectedView(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        view.backgroundColor = UIColor.hexColor(0xEFEFEF)
        return view
    }
}
