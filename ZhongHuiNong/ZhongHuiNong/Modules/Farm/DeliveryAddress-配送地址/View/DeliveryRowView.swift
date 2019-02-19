//
//  DeliveryRowView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/19.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryRowView: View {

    let titleLab = Label().then { (lab) in
        lab.text = "地址"
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 16)
    }
    
    let textTF = UITextField().then { (tf) in
        tf.placeholder = "请输入内容"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.keyboardType = .default
        tf.textColor = UIColor.hexColor(0x333333)
    }

    let arrowImg = ImageView().then { (img) in
        img.image = UIImage(named: "basket_cancel")
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF5F5F5)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(textTF)
        addSubview(arrowImg)
        addSubview(lineView)
    }
    
    override func updateUI() {
        super.updateUI()
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        }
        
        textTF.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(100)
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-70)
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.bottom.equalTo(self)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(1)
        }

    }

}
