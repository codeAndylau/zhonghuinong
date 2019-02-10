//
//  MineHeaderView.swift
//  ZhongHuiNong
//
//  Created by lau Andy on 2019/2/10.
//  Copyright © 2019年 Andylau. All rights reserved.
//

import UIKit

class MineHeaderView: View {

    var viewNotReady = true
    
    let headerImg = ImageView().then { (img) in
        img.image = UIImage(named: "farm_head")
        img.backgroundColor = Color.themeColor
    }
    
    let memberImg = ImageView().then { (img) in
        img.image = UIImage(named: "farm_head")
        img.backgroundColor = Color.themeColor
    }
    
    let nameLab = Label().then { (lab) in
        lab.text = "欧阳雨"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.boldSystemFont(ofSize: 18)
        lab.backgroundColor = Color.themeColor
    }
    
    let phoneLab = Label().then { (lab) in
        lab.text = "135****8888"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.backgroundColor = Color.themeColor
    }
    
    let priceLab = Label().then { (lab) in
        lab.text = "10,000"
        lab.textColor = UIColor.hexColor(0x010205)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        lab.backgroundColor = Color.themeColor
    }
    
    let priceNameLab = Label().then { (lab) in
        lab.text = "钱包余额(元)"
        lab.textColor = UIColor.hexColor(0x757882)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 13)
        lab.backgroundColor = Color.themeColor
    }
    
    let cardLab = Label().then { (lab) in
        lab.text = "10"
        lab.textColor = UIColor.hexColor(0x010205)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        lab.backgroundColor = Color.greyColor
    }
    
    let cardNameLab = Label().then { (lab) in
        lab.text = "会员卡(张)"
        lab.textColor = UIColor.hexColor(0x757882)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 13)
        lab.backgroundColor = Color.themeColor
    }
    
    let timesLab = Label().then { (lab) in
        lab.text = "10"
        lab.textColor = UIColor.hexColor(0x010205)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        lab.backgroundColor = Color.themeColor
    }
    
    let timesNameLab = Label().then { (lab) in
        lab.text = "免费配送(次)"
        lab.textColor = UIColor.hexColor(0x757882)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 13)
        lab.backgroundColor = Color.themeColor
    }
    
    let orderView = View().then { (view) in
        view.backgroundColor = UIColor.white
    }
    
    /// - Public methods
    
    class func loadView() -> MineHeaderView {
        let view = MineHeaderView()
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 290)
        view.backgroundColor = Color.whiteColor
        return view
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard viewNotReady else { return }
        addSubview(headerImg)
        addSubview(memberImg)
        addSubview(nameLab)
        addSubview(phoneLab)
        addSubview(priceLab)
        addSubview(cardLab)
        addSubview(timesLab)
        addSubview(priceNameLab)
        addSubview(cardNameLab)
        addSubview(timesNameLab)
        addSubview(orderView)
        activateConstraints()
    }
    
    func activateConstraints() {
        headerImg.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.width.height.equalTo(50)
        }
        
        memberImg.snp.makeConstraints { (make) in
            make.right.equalTo(self).inset(15)
            make.centerY.equalTo(headerImg)
            make.width.height.equalTo(50)
        }
        
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(headerImg.snp.right)
            make.right.greaterThanOrEqualTo(memberImg.snp.left).offset(-15)
            make.top.equalTo(headerImg)
        }
        
        phoneLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom)
        }
        
        
        priceLab.snp.makeConstraints { (make) in
            make.top.equalTo(headerImg.snp.bottom).offset(20)
            make.left.equalTo(headerImg.snp.left)
            make.height.equalTo(16)
            make.width.equalTo((kScreenW-30)/3)
        }
        
        cardLab.snp.makeConstraints { (make) in
            make.left.equalTo(priceLab.snp.right)
            make.centerY.equalTo(priceLab)
            make.width.height.equalTo(priceLab)
        }

        timesLab.snp.makeConstraints { (make) in
            make.left.equalTo(cardLab.snp.right)
            make.centerY.equalTo(cardLab)
            make.width.height.equalTo(priceLab)
        }
        
        priceNameLab.snp.makeConstraints { (make) in
            make.top.equalTo(priceLab.snp.bottom).offset(5)
            make.centerX.width.height.equalTo(priceLab)
        }
        
        cardNameLab.snp.makeConstraints { (make) in
            make.top.equalTo(cardLab.snp.bottom).offset(5)
            make.centerX.width.height.equalTo(cardLab)
        }
        
        timesNameLab.snp.makeConstraints { (make) in
            make.top.equalTo(timesLab.snp.bottom).offset(5)
            make.centerX.width.height.equalTo(timesLab)
        }
        
        orderView.snp.makeConstraints { (make) in
            make.top.equalTo(cardNameLab.snp.bottom).offset(30)
            make.centerX.equalTo(cardNameLab)
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(110)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // shadowCode
        orderView.layer.shadowColor = UIColor(red: 0, green: 0.03, blue: 0, alpha: 0.08).cgColor
        orderView.layer.shadowOffset = CGSize(width: 0, height: 1)
        orderView.layer.shadowOpacity = 1
        orderView.layer.shadowRadius = 16
        orderView.layer.cornerRadius = 10
        
        LogInfo("哈哈哈 --- \(self.bounds.maxY)")
    }

}