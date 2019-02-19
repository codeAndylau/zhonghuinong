
//
//  OrderAddressView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class OrderAddressView: View {

    let localImg = ImageView().then { (img) in
        img.image = UIImage(named: "mine_default_ portrait")
    }
    
    let modifyBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_modify"), for: .normal)
    }
    
    let nameLab = Label().then { (lab) in
        lab.text = "欧丫丫"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    let phoneLab = Label().then { (lab) in
        lab.text = "186********"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let addressLab = Label().then { (lab) in
        lab.text = "四川省成都市成华区天府新区高新区滨河花园A1栋1单元1号"
        lab.numberOfLines = 0
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(localImg)
        addSubview(modifyBtn)
        addSubview(nameLab)
        addSubview(phoneLab)
        addSubview(addressLab)
    }
    
    override func updateUI() {
        super.updateUI()

        localImg.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.width.equalTo(27)
            make.height.equalTo(35)
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

    }
    
    /// - Public methods
    class func loadView() -> OrderAddressView {
        let view = OrderAddressView()
        view.frame = CGRect(x: 0, y: 10, width: kScreenW, height: 100)
        view.backgroundColor = Color.whiteColor
        return view
    }

}
