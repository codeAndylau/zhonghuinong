//
//  DeliveryTimeView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/4.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryTimeView: View {

    let titleLab = Label().then { (lab) in
        lab.text = "配送时间"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    let cancelBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "basket_cancel"), for: .normal)
    }
    
    let tipsLab = Label().then { (lab) in
        lab.text = "请选择其中至少两天时间进行配送"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let day1Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周一", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.cuttingCorner(radius: 17.5)
        btn.setupBorder(width: 1, color: UIColor.hexColor(0xF3F3F3))
        btn.tag = 101
        btn.addTarget(self, action: #selector(btnClickedAction(sender:)), for: .touchUpInside)
    }
    
    let day2Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周二", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.cuttingCorner(radius: 17.5)
        btn.setupBorder(width: 1, color: UIColor.hexColor(0xF3F3F3))
        btn.tag = 102
        btn.addTarget(self, action: #selector(btnClickedAction(sender:)), for: .touchUpInside)
    }
    
    let day3Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周三", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.cuttingCorner(radius: 17.5)
        btn.setupBorder(width: 1, color: UIColor.hexColor(0xF3F3F3))
        btn.tag = 103
        btn.addTarget(self, action: #selector(btnClickedAction(sender:)), for: .touchUpInside)
    }
    
    let day4Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周四", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.cuttingCorner(radius: 17.5)
        btn.setupBorder(width: 1, color: UIColor.hexColor(0xF3F3F3))
        btn.tag = 104
        btn.addTarget(self, action: #selector(btnClickedAction(sender:)), for: .touchUpInside)
    }
    
    let day5Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周五", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.cuttingCorner(radius: 17.5)
        btn.setupBorder(width: 1, color: UIColor.hexColor(0xF3F3F3))
        btn.tag = 105
        btn.addTarget(self, action: #selector(btnClickedAction(sender:)), for: .touchUpInside)
    }

    let day6Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周六", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.cuttingCorner(radius: 17.5)
        btn.setupBorder(width: 1, color: UIColor.hexColor(0xF3F3F3))
        btn.tag = 106
        btn.addTarget(self, action: #selector(btnClickedAction(sender:)), for: .touchUpInside)
    }
    
    let day7Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周天", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.cuttingCorner(radius: 17.5)
        btn.setupBorder(width: 1, color: UIColor.hexColor(0xF3F3F3))
        btn.tag = 107
        btn.addTarget(self, action: #selector(btnClickedAction(sender:)), for: .touchUpInside)
    }
    
    let sureBtn = Button().then { (btn) in
        btn.setTitle("确认", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.cuttingCorner(radius: 22)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(tipsLab)
        addSubview(cancelBtn)
        addSubview(day1Btn)
        addSubview(day2Btn)
        addSubview(day3Btn)
        addSubview(day4Btn)
        addSubview(day5Btn)
        addSubview(day6Btn)
        addSubview(day7Btn)
        addSubview(sureBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        
        let space = (kScreenW - 75 - 4*65)/3
        let btn_w = 65
        let btn_h = 35
        
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
        }
        
        tipsLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.centerX.equalTo(self)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.centerY.equalTo(titleLab)
        }
        
        day1Btn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(35)
            make.top.equalTo(tipsLab.snp.bottom).offset(25)
            make.width.equalTo(btn_w)
            make.height.equalTo(btn_h)
        }
        
        day2Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day1Btn.snp.right).offset(space)
            make.centerY.width.height.equalTo(day1Btn)
        }
        
        
        day3Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day2Btn.snp.right).offset(space)
            make.centerY.width.height.equalTo(day1Btn)
        }
        
        day4Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day3Btn.snp.right).offset(space)
            make.centerY.width.height.equalTo(day1Btn)
        }
        
        day5Btn.snp.makeConstraints { (make) in
            make.left.width.height.equalTo(day1Btn)
            make.top.equalTo(day1Btn.snp.bottom).offset(15)
        }
        
        day6Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day5Btn.snp.right).offset(space)
            make.centerY.width.height.equalTo(day5Btn)
        }
        
        day7Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day6Btn.snp.right).offset(space)
            make.centerY.width.height.equalTo(day5Btn)
        }
        
        
        sureBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).inset(40)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-100)
            make.height.equalTo(44)
        }
    }
    
    var tagArray: [Int] = []
    
    @objc func btnClickedAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = UIColor.hexColor(0x1DD1A8)
            sender.setTitleColor(UIColor.white, for: .normal)
            tagArray.append(sender.tag)
        }else {
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
            for item in tagArray.enumerated() {
                if item.element == sender.tag {
                    tagArray.remove(at: item.offset)
                }
            }
        }
        debugPrints("选择的是那几个btn---\(tagArray)")
    }
    
    /// - Public methods
    class func loadView() -> DeliveryTimeView {
        let view = DeliveryTimeView()
        view.frame = CGRect(x: 0, y: kScreenH*0.45, width: kScreenW, height: kScreenH*0.55)
        view.backgroundColor = Color.whiteColor
        let corners: UIRectCorner = [.topLeft, .topRight]
        view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }

}
