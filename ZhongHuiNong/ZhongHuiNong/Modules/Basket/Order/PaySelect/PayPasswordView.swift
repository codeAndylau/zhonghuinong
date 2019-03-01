//
//  PayPasswordView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class PayPasswordView: View {

    let titleLab = Label().then { (lab) in
        lab.text = "请输入支付密码"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 18)
    }
    
    let cancelBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "basket_cancel"), for: .normal)
    }

    let payLab = Label().then { (lab) in
        lab.text = "¥0.0"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.boldSystemFont(ofSize: 40)
    }
    
    let boxView = PayBoxView()
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(cancelBtn)
        addSubview(payLab)
        addSubview(boxView)
        
        
        
        //        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification).subscribe(onNext: { (notification) in
        //            let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        //            let value = userInfo.object(forKey: UIResponder.keyboardFrameEndUserInfoKey)
        //            let keyboardRec = (value as AnyObject).cgRectValue
        //            let height = keyboardRec?.size.height
        //            debugPrints("键盘的高度---\(String(describing: height))")
        //        }).disposed(by: rx.disposeBag)
    }
    
    override func updateUI() {
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.centerX.equalTo(self)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.centerY.equalTo(titleLab).offset(-10)
        }
        
        payLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(16)
            make.centerX.equalTo(self)
        }
        
        boxView.snp.makeConstraints { (make) in
            make.top.equalTo(payLab.snp.bottom).offset(16)
            make.centerX.equalTo(self)
            make.width.equalTo(52*6)
            make.height.equalTo(52)
        }
        
        super.updateUI()
    }
  
    
    /// - Public methods
    class func loadView() -> PayPasswordView {
        let view = PayPasswordView()
        let viewH: CGFloat = IPhone_X == true ? 500 : 425
        view.frame = CGRect(x: 0, y: kScreenH-viewH, width: kScreenW, height: viewH)
        view.backgroundColor = Color.whiteColor
        let corners: UIRectCorner = [.topLeft, .topRight]
        view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }

}
