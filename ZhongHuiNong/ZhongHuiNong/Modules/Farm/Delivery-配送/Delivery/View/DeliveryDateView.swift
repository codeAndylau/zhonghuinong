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

    let tipsLab = Label().then { (lab) in
        lab.text = "以下是您所选择的每周蔬菜配送日期"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 10)
    }
    
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
        addSubview(tipsLab)
        addSubview(day1Btn)
        addSubview(day2Btn)
        addSubview(day3Btn)
        addSubview(day4Btn)
        addSubview(day5Btn)
        addSubview(day6Btn)
        addSubview(day7Btn)
    }
    
    override func updateUI() {
        super.updateUI()
        
        tipsLab.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(10)
        }
        
        day1Btn.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(self).offset(10)
            make.width.equalTo((kScreenW-50)/7)
            make.height.equalTo(30)
        }

        day2Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day1Btn.snp.right).offset(5)
            make.centerY.width.height.equalTo(day1Btn)
        }
        
        day3Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day2Btn.snp.right).offset(5)
            make.centerY.width.height.equalTo(day2Btn)
        }
        
        day4Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day3Btn.snp.right).offset(5)
            make.centerY.width.height.equalTo(day3Btn)
        }

        day5Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day4Btn.snp.right).offset(5)
            make.centerY.width.height.equalTo(day4Btn)
        }
        
        day6Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day5Btn.snp.right).offset(5)
            make.centerY.width.height.equalTo(day5Btn)
        }
        
        day7Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day6Btn.snp.right).offset(5)
            make.centerY.width.height.equalTo(day6Btn)
        }
        
    }
    
    func dayBtnAction(_ sender: Button) {
        
        // strokeCode
        let borderLayer1 = CALayer()
        borderLayer1.frame = sender.bounds
        borderLayer1.backgroundColor = UIColor.hexColor(0x1DD1A8, alpha: 0.4).cgColor
        borderLayer1.cornerRadius = sender.bounds.height/2
        sender.layer.insertSublayer(borderLayer1, at: 0)
        // fillCode
        let bgLayer1 = CALayer()
        bgLayer1.frame = sender.bounds.insetBy(dx: 2.5, dy: 2.5)
        bgLayer1.backgroundColor = UIColor.hexColor(0x1DD1A8, alpha: 0.3).cgColor
        bgLayer1.cornerRadius = sender.bounds.insetBy(dx: 2.5, dy: 2.5).height/2
        sender.layer.insertSublayer(bgLayer1, at: 0)
    }
    
    func dayBtnHeightAction(_ sender: Button) {
        
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
    
    /// 本地计算那一天是可以选择配送蔬菜的
    var dispatchDate: DispatchDateInfo = DispatchDateInfo() {
        
        didSet {
            
            // FIXME: - 1. 显示用户选择配送的蔬菜日期
            if dispatchDate.monday    { dayBtnAction(day1Btn) }
            if dispatchDate.tuesday   { dayBtnAction(day2Btn) }
            if dispatchDate.wednesday { dayBtnAction(day3Btn) }
            if dispatchDate.thursday  { dayBtnAction(day4Btn) }
            if dispatchDate.friday    { dayBtnAction(day5Btn) }
            if dispatchDate.saturday  { dayBtnAction(day6Btn) }
            if dispatchDate.sunday    { dayBtnAction(day7Btn) }
            
            // FIXME: - 2. 判断今天能否可以选择（只能提前两天选择蔬菜）
            let week: Int = (Calendar.current as NSCalendar).components([NSCalendar.Unit.weekday], from: Date()).weekday! - 1

            switch week {
                
            case 0: if dispatchDate.wednesday { dayBtnHeightAction(day3Btn) }
            case 1: if dispatchDate.thursday  { dayBtnHeightAction(day4Btn) }
            case 2: if dispatchDate.friday    { dayBtnHeightAction(day5Btn) }
            case 3: if dispatchDate.saturday  { dayBtnHeightAction(day6Btn) }
            case 4: if dispatchDate.sunday    { dayBtnHeightAction(day7Btn) }
            case 5: if dispatchDate.monday    { dayBtnHeightAction(day1Btn) }
            case 6: if dispatchDate.tuesday   { dayBtnHeightAction(day2Btn) }
                
            default:
                break
            }
        }
    }

}
