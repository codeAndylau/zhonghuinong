//
//  FlashView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/15.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class FlashView: View {

    let selectView = View().then { (view) in
        view.backgroundColor = UIColor.clear
    }
    
    let countdownView = View().then { (view) in
        view.backgroundColor = UIColor.white
    }
    
    let countdownTitleLab = Label().then { (lab) in
        lab.text = "抢购中，先抢先得噢！"
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 13)
    }
    
    let countdowntipsLab = Label().then { (lab) in
        lab.text = "距结束"
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 10)
    }
    
    let countdownSubView = CountDownView()
    
    override func makeUI() {
        super.makeUI()
        addSubview(selectView)
        addSubview(countdownView)
        countdownView.addSubview(countdownTitleLab)
        countdownView.addSubview(countdownSubView)
        countdownView.addSubview(countdowntipsLab)
    }
    
    override func updateUI() {
        super.updateUI()
        selectView.snp.makeConstraints { (make) in
            make.top.equalTo(kNavBarH)
            make.left.width.equalTo(self)
            make.height.equalTo(56)
        }
        
        countdownView.snp.makeConstraints { (make) in
            make.top.equalTo(selectView.snp.bottom)
            make.centerX.equalTo(self)
            make.height.equalTo(36)
            make.width.equalTo(kScreenW-30)
        }
        
        countdownTitleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
        
        countdownSubView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.width.equalTo(65)
            make.height.equalToSuperview()
        }
        
        countdowntipsLab.snp.makeConstraints { (make) in
            make.right.equalTo(countdownSubView.snp.left).offset(-8)
            make.centerY.equalToSuperview()
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // fillCode
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.44, blue: 0.26, alpha: 1).cgColor, UIColor(red: 1, green: 0.3, blue: 0.31, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = bounds
        bgLayer1.startPoint = CGPoint(x: 0, y: 0.5)
        bgLayer1.endPoint = CGPoint(x: 0.5, y: 0.5)
        layer.insertSublayer(bgLayer1, at: 0)
        
        // shadowCode
        countdownView.layer.shadowColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.28).cgColor
        countdownView.layer.shadowOffset = CGSize(width: 0, height: 2)
        countdownView.layer.shadowOpacity = 1
        countdownView.layer.shadowRadius = 6
        countdownView.layer.cornerRadius = 6
    }
    
    /// Public method
    
    class func loadView() -> FlashView {
        let view = FlashView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: FlashViewH))
        return view
    }

}
