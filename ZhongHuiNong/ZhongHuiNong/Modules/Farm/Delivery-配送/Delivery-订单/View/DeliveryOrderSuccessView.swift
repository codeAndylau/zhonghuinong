//
//  DeliveryOrderSuccessView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/20.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryOrderSuccessView: PaySuccessView {
    
    let tipsLab = Label().then { (lab) in
        lab.text = "订单提交成功，将在每周二、周五进行配送 次周如未更改菜单，则按本次菜单继续为您配送 "
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.numberOfLines = 0
    }
    
    let sureBtn = Button().then { (btn) in
        btn.setTitle("确认", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.cuttingCorner(radius: 22)
    }
    
    override func makeUI() {
        
        titleLab.text = "提交成功"
        
        addSubview(titleLab)
        addSubview(cancelBtn)
        addSubview(centerImg)
        addSubview(tipsLab)
        addSubview(sureBtn)
        
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
        
        centerImg.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(33)
            make.centerX.equalTo(self)
        }
        
        tipsLab.snp.makeConstraints { (make) in
            make.top.equalTo(centerImg.snp.bottom).offset(10)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-80)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-40)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-120)
            make.height.equalTo(44)
        }
    }

    /// - Public methods
    override class func loadView() -> DeliveryOrderSuccessView {
        let view = DeliveryOrderSuccessView()
        view.frame = CGRect(x: 0, y: kScreenH*0.56, width: kScreenW, height: kScreenH*0.44)
        view.backgroundColor = Color.whiteColor
        let corners: UIRectCorner = [.topLeft, .topRight]
        view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }

}
