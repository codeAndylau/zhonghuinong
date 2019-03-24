//
//  WechatLoginView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class WechatLoginView: View {

    let titleImg = ImageView().then { (img) in
        img.image = UIImage(named: "login_Headline")
        img.contentMode = .scaleAspectFit
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "有机，是对天然食材和自然之道的 一份责任"
        lab.textAlignment = .left
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.numberOfLines = 0
    }
    
    let backImg = ImageView().then { (img) in
        img.image = UIImage(named: "login_backImage")
        img.contentMode = .scaleAspectFill
    }
    
    let wechatBtn = Button(type: .custom).then { (btn) in
        btn.set(image: UIImage(named: "login_wech"), title: "微信", titlePosition: .right, additionalSpacing: 10, state: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.adjustsImageWhenHighlighted = true
        btn.adjustsImageWhenHighlighted = false
    }
    
    let otherBtn = Button(type: .custom).then { (btn) in
        btn.setTitle("验证码登录", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.adjustsImageWhenHighlighted = false
    }
    
    let tipsLab = Label().then { (lab) in
        lab.text = "登录代表你阅读并同意"
        lab.textAlignment = .right
        lab.textColor = UIColor.hexColor(0xC8C8C8)
        lab.font = UIFont.systemFont(ofSize: 13)
    }
    
    let serviceBtn = Button(type: .custom).then { (btn) in
        btn.setTitle("服务条款", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x1DD1A8), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.titleLabel?.textAlignment = .left
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleImg)
        addSubview(titleLab)
        addSubview(backImg)
        //addSubview(tipsLab)
        //addSubview(serviceBtn)
        addSubview(otherBtn)
        addSubview(wechatBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        
        titleImg.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(150)
            make.left.equalTo(50)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleImg.snp.bottom).offset(20)
            make.left.equalTo(50)
            make.width.equalTo(265)
            make.height.equalTo(50)
        }
        
        backImg.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW)
        }
        
//        tipsLab.snp.makeConstraints { (make) in
//            make.bottom.equalTo(self).offset(-60)
//            make.centerX.equalTo(self).offset(-20)
//        }
//
//        serviceBtn.snp.makeConstraints { (make) in
//            make.left.equalTo(tipsLab.snp.right)
//            make.centerY.equalTo(tipsLab)
//        }
        
        otherBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-120)
            make.centerX.equalTo(self)
        }
        
        wechatBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(otherBtn.snp.top).offset(-18)
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).offset(-30)
            make.height.equalTo(54)
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // fillCode
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor.hexColor(0x29D69B).cgColor, UIColor.hexColor(0x0BC4B4).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = wechatBtn.bounds.insetBy(dx: 3, dy: 3)
        bgLayer1.startPoint = CGPoint(x: 0.0, y: 1.0)
        bgLayer1.endPoint = CGPoint(x: 0.5, y: 1.0)
        bgLayer1.cornerRadius = wechatBtn.bounds.insetBy(dx: 3, dy: 3).height/2
        wechatBtn.layer.insertSublayer(bgLayer1, at: 0)
        
        let bgLayer2 = CALayer()
        bgLayer2.frame = wechatBtn.bounds
        bgLayer2.backgroundColor = UIColor.hexColor(0x1DD1A8, alpha: 0.2).cgColor
        bgLayer2.cornerRadius = wechatBtn.bounds.height/2
        wechatBtn.layer.insertSublayer(bgLayer2, at: 0)
        
    }
    
    /// - Publich Methods
    class func loadView() -> WechatLoginView {
        let view = WechatLoginView(frame: UIScreen.main.bounds)
        return view
    }
    
    
}
