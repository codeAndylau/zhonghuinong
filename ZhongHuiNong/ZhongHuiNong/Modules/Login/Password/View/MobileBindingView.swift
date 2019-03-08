//
//  MobileBindingView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/8.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MobileBindingView: View {

    let titleLab = Label().then { (lab) in
        lab.text = "手机号"
        lab.textAlignment = .left
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.numberOfLines = 0
    }
    
    let phoneTF = UITextField().then { (tf) in
        tf.placeholder = "请输入手机号"
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.keyboardType = .numberPad
    }
    
    let codeBtn = Button(type: .custom).then { (btn) in
        btn.setTitle("获取验证码", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x16C6A3), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF5F5F5)
    }
    
    override func makeUI() {
        super.makeUI()
        
        addSubview(titleLab)
        addSubview(phoneTF)
        addSubview(codeBtn)
        addSubview(lineView)
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        }

        codeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        phoneTF.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(90)
            make.centerY.equalTo(self)
            make.right.equalTo(codeBtn.snp.left).offset(-15)
            make.height.equalTo(35)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
    /// Public method
    class func loadView() -> MobileBindingView {
        let view = MobileBindingView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 50))
        return view
    }

}
