//
//  VegetablesView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/20.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class VegetablesView: View {
    
    let btn1 = ImageView()
    
    let btn2 = ImageView()
    
    let btn3 = ImageView()
    
    let btn4 = ImageView()
    
    let btn5 = ImageView()

    override func makeUI() {
        super.makeUI()
        addSubview(btn1)
        addSubview(btn2)
        addSubview(btn3)
        addSubview(btn4)
        addSubview(btn5)
    }
    
    override func updateUI() {
        super.updateUI()
        btn1.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(self)
            make.width.height.equalTo(44)
        }
        
        btn2.snp.makeConstraints { (make) in
            make.left.equalTo(btn1.snp.right).offset(10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(44)
        }
        
        btn3.snp.makeConstraints { (make) in
            make.left.equalTo(btn2.snp.right).offset(10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(44)
        }
        
        btn4.snp.makeConstraints { (make) in
            make.left.equalTo(btn3.snp.right).offset(10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(44)
        }
        
        btn5.snp.makeConstraints { (make) in
            make.left.equalTo(btn4.snp.right).offset(10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(44)
        }
    }

}
