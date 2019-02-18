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

    let day1Btn = UIButton(type: .custom).then { (btn) in
        btn.setTitle("周一", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let day2Btn = UIButton(type: .custom).then { (btn) in
        btn.setTitle("周二", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let day3Btn = UIButton(type: .custom).then { (btn) in
        btn.setTitle("周三", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let day4Btn = UIButton(type: .custom).then { (btn) in
        btn.setTitle("周四", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let day5Btn = UIButton(type: .custom).then { (btn) in
        btn.setTitle("周五", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let day6Btn = UIButton(type: .custom).then { (btn) in
        btn.setTitle("周六", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let day7Btn = UIButton(type: .custom).then { (btn) in
        btn.setTitle("周天", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func makeUI() {
        super.makeUI()
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
        day1Btn.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(self)
            make.width.equalTo(kScreenW/7)
            make.height.equalTo(50)
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

}
