//
//  MineAddressTitleView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import Then

class MineAddressTitleView: View {

    let titleLab = Label().then { (lab) in
        lab.text = "所在区域"
        lab.textColor = UIColor.black
        lab.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    let cancelButton = Button().then { (btn) in
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x1DD1A8), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    let provinceButton = Button().then { (btn) in
        btn.setTitle("请选择", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.tag = 100
    }
    
    let cityButton = Button().then { (btn) in
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.tag = 200
    }
    
    let districtButton = Button().then { (btn) in
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.tag = 300
    }
    
    let townButton = Button().then { (btn) in
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.tag = 400
    }
    
    let bottomLine = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0x1DD1A8)
        view.cuttingCorner(radius: 1.5)
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xf5f5f5)
    }
    
    var currentX: CGFloat = 0
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(cancelButton)
        addSubview(provinceButton)
        addSubview(cityButton)
        addSubview(districtButton)
        addSubview(townButton)
        addSubview(lineView)
    }
    
    override func updateUI() {
        super.updateUI()
        titleLab.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        provinceButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview()
        }
        
        cityButton.snp.makeConstraints { (make) in
            make.left.equalTo(provinceButton.snp.right).offset(5)
            make.bottom.equalToSuperview()
        }
        
        districtButton.snp.makeConstraints { (make) in
            make.left.equalTo(cityButton.snp.right).offset(5)
            make.bottom.equalToSuperview()
        }
        
        townButton.snp.makeConstraints { (make) in
            make.left.equalTo(districtButton.snp.right).offset(5)
            make.bottom.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }

}
