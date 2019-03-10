
//
//  OrderAddressView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class OrderAddressView: View {

    let localView = View()
    let localImg = ImageView().then { (img) in
        img.image = UIImage(named: "farm_delivery_local")
    }
    
    let modifyBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "mine_arrow"), for: .normal)
    }
    
    let nameLab = Label().then { (lab) in
        lab.text = ""  // 欧丫丫
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    let phoneLab = Label().then { (lab) in
        lab.text = "" // 186********
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let addressLab = Label().then { (lab) in
        lab.text = "" // 四川省成都市成华区天府新区高新区滨河花园A1栋1单元1号
        lab.numberOfLines = 0
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let tipLab = Label().then { (lab) in
        lab.text = "您还没有添加收获地址哦"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.boldSystemFont(ofSize: 15)
        lab.isHidden = true
    }
    
    let sureBtn = Button()
    
    override func makeUI() {
        super.makeUI()
        
        addSubview(localView)
        localView.addSubview(localImg)
        
        addSubview(localImg)
        addSubview(modifyBtn)
        addSubview(nameLab)
        addSubview(phoneLab)
        addSubview(addressLab)
        addSubview(tipLab)
        addSubview(sureBtn)
        
    }
    
    override func updateUI() {
        super.updateUI()

        localView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.centerY.equalTo(self)
            make.width.height.equalTo(55)
        }
        
        localImg.snp.makeConstraints { (make) in
            make.center.equalTo(localView)
        }

        nameLab.snp.makeConstraints { (make) in
            make.top.equalTo(18)
            make.left.equalTo(localImg.snp.right).offset(13)
            make.height.equalTo(21)
        }

        phoneLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab.snp.right).offset(7)
            make.bottom.equalTo(nameLab.snp.bottom)
        }

        addressLab.snp.makeConstraints { (make) in
            make.top.equalTo(nameLab.snp.bottom).offset(6)
            make.left.equalTo(nameLab.snp.left)
            make.right.equalTo(self).offset(-50)
            make.bottom.lessThanOrEqualTo(self).offset(-10)
        }

        modifyBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
        }
        
        tipLab.snp.makeConstraints { (make) in
            make.left.equalTo(localImg.snp.right).offset(13)
            make.centerY.equalTo(self)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

    }
    
    /// - Public methods
    class func loadView() -> OrderAddressView {
        let view = OrderAddressView()
        view.frame = CGRect(x: 0, y: 10, width: kScreenW, height: 100)
        view.backgroundColor = Color.whiteColor
        return view
    }

}
