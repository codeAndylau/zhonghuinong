//
//  DeliveryFooterView.swift
//  ZhongHuiNong
//
//  Created by lau Andy on 2019/2/18.
//  Copyright © 2019年 Andylau. All rights reserved.
//

import UIKit

class DeliveryFooterView: View {
    
    lazy var lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xE5E5E5)
    }
    
    lazy var titleLab = Label().then { (lab) in
        lab.text = "配送次数"
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.hexColor(0x4A4A4A)
    }
    
    lazy var numLab = Label().then { (lab) in
        lab.text = "-1"
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        lab.textColor = UIColor.hexColor(0x4A4A4A)
    }
    
    lazy var countLab = Label().then { (lab) in
        lab.text = "食材总重"
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.hexColor(0x4A4A4A)
    }
    
    lazy var totalCountLab = Label().then { (lab) in
        lab.text = "7.75kg"
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        lab.textColor = UIColor.hexColor(0x1DD1A8)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(lineView)
        addSubview(titleLab)
        addSubview(numLab)
        addSubview(countLab)
        addSubview(totalCountLab)
    }

    override func updateUI() {
        super.updateUI()
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).inset(30)
            make.top.equalTo(self)
            make.height.equalTo(0.5)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.top.equalTo(lineView.snp.bottom).offset(13)
        }
        
        numLab.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-30)
            make.centerY.equalTo(titleLab)
        }
        
        countLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
        }
        
        totalCountLab.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-30)
            make.centerY.equalTo(countLab)
        }
    }
    
    
    /// LoadView
    class func loadView() -> DeliveryFooterView {
        let view = DeliveryFooterView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 88))
        return view
    }
}
