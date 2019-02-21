//
//  GoodsDetailAddressView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class GoodsDetailAddressView: View {

    let dot1View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0x1DD1A8)
        view.cuttingCorner(radius: 5)
    }
    
    let line1View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0x1DD1A8)
        view.cuttingCorner(radius: 1)
    }
    
    let dot2View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0x1DD1A8)
        view.cuttingCorner(radius: 5)
    }
    
    let line2View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xDDDDDD)
        view.cuttingCorner(radius: 1)
    }
    
    let dot3View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xDDDDDD)
        view.cuttingCorner(radius: 5)
    }
    
    let line3View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xDDDDDD)
        view.cuttingCorner(radius: 1)
    }
    
    let dot4View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xDDDDDD)
        view.cuttingCorner(radius: 5)
    }
    
    let line4View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF5F5F5)
    }
    
    let lab1 = Label().then { (lab) in
        lab.text = "有机原产地"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textAlignment = .center
    }
    
    let lab2 = Label().then { (lab) in
        lab.text = "商家直邮仓发货"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textAlignment = .center
    }
    
    let lab3 = Label().then { (lab) in
        lab.text = "成都"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textAlignment = .center
    }
    
    let lab4 = Label().then { (lab) in
        lab.text = "收货"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textAlignment = .center
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(dot1View)
        addSubview(dot2View)
        addSubview(dot3View)
        addSubview(dot4View)
        
        addSubview(line1View)
        addSubview(line2View)
        addSubview(line3View)
        addSubview(line4View)
        
        addSubview(lab1)
        addSubview(lab2)
        addSubview(lab3)
        addSubview(lab4)
    }
    
    override func updateUI() {
        super.updateUI()
        
        dot1View.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(60)
            make.width.height.equalTo(10)
        }
        
        line1View.snp.makeConstraints { (make) in
            make.left.equalTo(dot1View.snp.right).offset(5)
            make.centerY.equalTo(dot1View)
            make.right.equalTo(dot2View.snp.left).offset(-5)
            make.height.equalTo(2)
        }
        
        dot2View.snp.makeConstraints { (make) in
            make.left.equalTo(dot1View.snp.right).offset((kScreenW-160)/3)
            make.centerY.equalTo(dot1View)
            make.width.height.equalTo(10)
        }
        
        line2View.snp.makeConstraints { (make) in
            make.left.equalTo(dot2View.snp.right).offset(5)
            make.centerY.equalTo(dot1View)
            make.right.equalTo(dot3View.snp.left).offset(-5)
            make.height.equalTo(2)
        }
        
        dot3View.snp.makeConstraints { (make) in
            make.left.equalTo(dot2View.snp.right).offset((kScreenW-160)/3)
            make.centerY.equalTo(dot1View)
            make.width.height.equalTo(10)
        }
        
        line3View.snp.makeConstraints { (make) in
            make.left.equalTo(dot3View.snp.right).offset(5)
            make.centerY.equalTo(dot1View)
            make.right.equalTo(dot4View.snp.left).offset(-5)
            make.height.equalTo(2)
        }
        
        dot4View.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.right.equalTo(-60)
            make.width.height.equalTo(10)
        }
        
        lab1.snp.makeConstraints { (make) in
            make.top.equalTo(dot1View.snp.bottom).offset(10)
            make.centerX.equalTo(dot1View)
        }
        
        lab2.snp.makeConstraints { (make) in
            make.top.equalTo(dot2View.snp.bottom).offset(10)
            make.centerX.equalTo(dot2View)
        }
        
        lab3.snp.makeConstraints { (make) in
            make.top.equalTo(dot3View.snp.bottom).offset(10)
            make.centerX.equalTo(dot3View)
        }
        
        lab4.snp.makeConstraints { (make) in
            make.top.equalTo(dot4View.snp.bottom).offset(10)
            make.centerX.equalTo(dot4View)
        }
        
        line4View.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self)
            make.height.equalTo(1)
        }
        
    }
    
    

}
