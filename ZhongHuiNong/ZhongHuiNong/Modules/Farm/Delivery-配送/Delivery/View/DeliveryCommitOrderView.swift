//
//  DeliveryCommitOrderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryCommitOrderView: View {

    let contView = View().then { (view) in
        view.backgroundColor = Color.whiteColor
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xE5E5E5)
    }
    
    let leftImg = ImageView().then { (img) in
        img.image = UIImage(named: "farm_basket")
    }
    
    let totalLab = Label().then { (lab) in
        lab.text = "7.95kg"
        lab.textColor = UIColor.hexColor(0x1DD1A8)
        lab.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    let totalTipLab = Label().then { (lab) in
        lab.text = "/10kg"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let timesLab = Label().then { (lab) in
        lab.text = "剩余免配送次数：88"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.boldSystemFont(ofSize: 11)
    }
    
    let orderBtn = Button(type: UIButton.ButtonType.custom).then { (btn) in
        btn.setTitle("提交订单", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(contView)
        contView.addSubview(lineView)
        contView.addSubview(leftImg)
        contView.addSubview(totalLab)
        contView.addSubview(totalTipLab)
        contView.addSubview(timesLab)
        contView.addSubview(orderBtn)
    }

    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(56)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        leftImg.snp.makeConstraints { (make) in
            make.left.equalTo(contView).offset(15)
            make.centerY.equalTo(contView)
        }
        
        totalLab.snp.makeConstraints { (make) in
            make.left.equalTo(leftImg.snp.right).offset(12)
            make.top.equalTo(contView).offset(8)
        }
        
        totalTipLab.snp.makeConstraints { (make) in
            make.left.equalTo(totalLab.snp.right)
            make.bottom.equalTo(totalLab)
        }
        
        timesLab.snp.makeConstraints { (make) in
            make.left.equalTo(totalLab)
            make.top.equalTo(totalLab.snp.bottom)
        }
        
        orderBtn.snp.makeConstraints { (make) in
            make.right.equalTo(contView).offset(-15)
            make.centerY.equalTo(contView)
            make.width.equalTo(110)
            make.height.equalTo(40)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // shadowCode
        orderBtn.layer.shadowColor = UIColor(red: 0.11, green: 0.82, blue: 0.66, alpha: 0.5).cgColor
        orderBtn.layer.shadowOffset = CGSize(width: 0, height: 3)
        orderBtn.layer.shadowOpacity = 1
        orderBtn.layer.shadowRadius = 5
        orderBtn.layer.cornerRadius = 20
    }
    
    /// - Public methods
    class func loadView() -> DeliveryCommitOrderView {
        let view = DeliveryCommitOrderView()
        view.frame = CGRect(x: 0, y: kScreenH-kBottomViewH, width: kScreenW, height: kBottomViewH)
        view.backgroundColor = Color.whiteColor
        return view
    }
    
}
