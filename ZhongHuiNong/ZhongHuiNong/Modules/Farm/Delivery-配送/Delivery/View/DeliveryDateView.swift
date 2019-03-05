//
//  DeliveryDateView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 配送选货周一到周天
class DeliveryDateView: View {

    let day1Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周一", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let day2Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周二", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let day2View = View()
    let day2HeightView = View()
    
    let day3Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周三", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let day4Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周四", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let day5Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周五", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let day5View = View()
    let day5HeightView = View()
    
    let day6Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周六", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let day7Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周天", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(day1Btn)
        addSubview(day2View)
        addSubview(day2HeightView)
        addSubview(day2Btn)
        addSubview(day3Btn)
        addSubview(day4Btn)
        addSubview(day5View)
        addSubview(day5HeightView)
        addSubview(day5Btn)
        addSubview(day6Btn)
        addSubview(day7Btn)
    }
    
    override func updateUI() {
        super.updateUI()
        
        day1Btn.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(self)
            make.width.equalTo(kScreenW/7)
            make.height.equalTo(30)
        }
        
        day2View.snp.makeConstraints { (make) in
            make.left.equalTo(day1Btn.snp.right)
            make.centerY.width.height.equalTo(day1Btn)
        }
        
        day2HeightView.snp.makeConstraints { (make) in
            make.left.equalTo(day1Btn.snp.right)
            make.centerY.width.height.equalTo(day1Btn)
        }
        
        day2Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day1Btn.snp.right)
            make.centerY.width.height.equalTo(day1Btn)
        }
        
        day3Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day2Btn.snp.right)
            make.centerY.width.height.equalTo(day2Btn)
        }
        
        day4Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day3Btn.snp.right)
            make.centerY.width.height.equalTo(day3Btn)
        }
        
        day5View.snp.makeConstraints { (make) in
            make.left.equalTo(day4Btn.snp.right)
            make.centerY.width.height.equalTo(day4Btn)
        }
        
        day5HeightView.snp.makeConstraints { (make) in
            make.left.equalTo(day4Btn.snp.right)
            make.centerY.width.height.equalTo(day4Btn)
        }
        
        day5Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day4Btn.snp.right)
            make.centerY.width.height.equalTo(day4Btn)
        }
        
        day6Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day5Btn.snp.right)
            make.centerY.width.height.equalTo(day5Btn)
        }
        
        day7Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day6Btn.snp.right)
            make.centerY.width.height.equalTo(day6Btn)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dayBtnAction(day2View)
        dayBtnHeightAction(day2HeightView)
        
        dayBtnAction(day5View)
        dayBtnHeightAction(day5HeightView)
        
        day2View.isHidden = true
        day5HeightView.isHidden = true
    }
    
    func day2Height() {
        day5HeightView.isHidden = true
        day2View.isHidden = true
        
        day5View.isHidden = false
        day2HeightView.isHidden = false
    }
    
    func day5Height() {
        
        day5HeightView.isHidden = false
        day2View.isHidden = false
        
        day5View.isHidden = true
        day2HeightView.isHidden = true
    }
    
    func dayBtnAction(_ sender: View) {
        
        day5Btn.setTitleColor(UIColor.white, for: .normal)
        
        // strokeCode
        let borderLayer1 = CALayer()
        borderLayer1.frame = sender.bounds
        borderLayer1.backgroundColor = UIColor.hexColor(0x1DD1A8, alpha: 0.4).cgColor
        borderLayer1.cornerRadius = sender.bounds.height/2
        sender.layer.insertSublayer(borderLayer1, at: 0)
        // fillCode
        let bgLayer1 = CALayer()
        bgLayer1.frame = sender.bounds.insetBy(dx: 2.5, dy: 2.5)
        bgLayer1.backgroundColor = UIColor.hexColor(0x1DD1A8, alpha: 0.5).cgColor
        bgLayer1.cornerRadius = sender.bounds.insetBy(dx: 2.5, dy: 2.5).height/2
        sender.layer.insertSublayer(bgLayer1, at: 0)
    }
    
    func dayBtnHeightAction(_ sender: View) {
        
        day2Btn.setTitleColor(UIColor.white, for: .normal)
        
        // strokeCode
        let borderLayer1 = CALayer()
        borderLayer1.frame = sender.bounds
        borderLayer1.backgroundColor = UIColor.hexColor(0x1DD1A8, alpha: 0.4).cgColor
        borderLayer1.cornerRadius = sender.bounds.height/2
        sender.layer.insertSublayer(borderLayer1, at: 0)
        // fillCode
        let bgLayer1 = CALayer()
        bgLayer1.frame = sender.bounds.insetBy(dx: 2.5, dy: 2.5)
        bgLayer1.backgroundColor = UIColor.hexColor(0x1DD1A8).cgColor
        bgLayer1.cornerRadius = sender.bounds.insetBy(dx: 2.5, dy: 2.5).height/2
        sender.layer.insertSublayer(bgLayer1, at: 0)
    }

}
