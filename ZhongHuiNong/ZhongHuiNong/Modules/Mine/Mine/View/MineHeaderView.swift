//
//  MineHeaderView.swift
//  ZhongHuiNong
//
//  Created by lau Andy on 2019/2/10.
//  Copyright © 2019年 Andylau. All rights reserved.
//

import UIKit

class MineHeaderView: View {
    
    let headerBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "mine_default_ portrait"), for: .normal)
        btn.cuttingCorner(radius: 25)
    }
    
    let memberBtn = Button().then { (btn) in
        btn.setTitleColor(UIColor.hexColor(0x9B9B9B), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.adjustsImageWhenHighlighted = false
    }
    
    let nameLab = Label().then { (lab) in
        lab.text = "欧丫丫"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    let phoneLab = Label().then { (lab) in
        lab.text = "135****8888"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let priceLab = Label().then { (lab) in
        lab.text = "10,000"
        lab.textColor = UIColor.hexColor(0x010205)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let priceNameLab = Label().then { (lab) in
        lab.text = "钱包余额(元)"
        lab.textColor = UIColor.hexColor(0x757882)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    let cardLab = Label().then { (lab) in
        lab.text = "10"
        lab.textColor = UIColor.hexColor(0x010205)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let cardNameLab = Label().then { (lab) in
        lab.text = "会员卡(张)"
        lab.textColor = UIColor.hexColor(0x757882)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    let timesLab = Label().then { (lab) in
        lab.text = "10"
        lab.textColor = UIColor.hexColor(0x010205)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let timesNameLab = Label().then { (lab) in
        lab.text = "免费配送(次)"
        lab.textColor = UIColor.hexColor(0x757882)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    let orderView = MineOrderView().then { (view) in
        view.backgroundColor = UIColor.white
    }
    
    let walletBtn = Button()
    let vegetablesBtn = Button()
    
    override func makeUI() {
        super.makeUI()
        addSubview(headerBtn)
        addSubview(memberBtn)
        addSubview(nameLab)
        addSubview(phoneLab)
        addSubview(priceLab)
        addSubview(cardLab)
        addSubview(timesLab)
        addSubview(priceNameLab)
        addSubview(cardNameLab)
        addSubview(timesNameLab)
        addSubview(orderView)
        addSubview(walletBtn)
        addSubview(vegetablesBtn)
        activateConstraints()
    }
    
    func activateConstraints() {
        
        headerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.width.height.equalTo(50)
        }
        
        memberBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).inset(15)
            make.centerY.equalTo(headerBtn).offset(-10)
            make.width.height.equalTo(50)
        }
        
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(headerBtn.snp.right).offset(10)
            make.right.greaterThanOrEqualTo(memberBtn.snp.left).offset(-15)
            make.top.equalTo(headerBtn).offset(5)
        }
        
        phoneLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom)
        }
        
        priceLab.snp.makeConstraints { (make) in
            make.top.equalTo(headerBtn.snp.bottom).offset(20)
            make.left.equalTo(headerBtn.snp.left)
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
            make.height.equalTo(130)
        }
        
        walletBtn.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(priceLab)
            make.bottom.equalTo(priceNameLab)
        }
        
        vegetablesBtn.snp.makeConstraints { (make) in
            make.left.top.equalTo(cardLab)
            make.right.equalTo(timesLab)
            make.bottom.equalTo(priceNameLab)
        }
        
        memberBtn.set(image: UIImage(named: "mine_vip"), title: "尊享会员", titlePosition: .bottom, additionalSpacing: 5, state: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // shadowCode
        orderView.layer.shadowColor = UIColor(red: 0, green: 0.03, blue: 0, alpha: 0.08).cgColor
        orderView.layer.shadowOffset = CGSize(width: 0, height: 1)
        orderView.layer.shadowOpacity = 1
        orderView.layer.shadowRadius = 16
        orderView.layer.cornerRadius = 10
    }
    
    /// - Public methods
    class func loadView() -> MineHeaderView {
        let view = MineHeaderView()
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 290)
        view.backgroundColor = Color.whiteColor
        return view
    }
    
    var user: User = User() {
        didSet {
            nameLab.text = user.username
            headerBtn.kf.setImage(with: URL(string: user.user_Img), for: .normal, placeholder: UIImage(named: "mine_default_ portrait"))
            phoneLab.text = ""
            if user.isVip {
                memberBtn.set(image: UIImage(named: "mine_vip"), title: "尊享会员", titlePosition: .bottom, additionalSpacing: 5, state: .normal)
            }else {
                memberBtn.set(image: UIImage(named: "mine_nonvip"), title: "开通会员", titlePosition: .bottom, additionalSpacing: 5, state: .normal)
            }
        }
    }

}
