//
//  MineLogisticsAddressView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

let dotViewH : CGFloat = 6

class MineLogisticsAddressView: GoodsDetailAddressView {

    var ststus = 1 {
        didSet {
            
            /*  1.在途中 2.正在派件 3.已签收 4.派送失败  */
            
            switch ststus {
                
            case 0:
                
                lab1.textColor = UIColor.hexColor(0x1DD1A8)
                dot1View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                
            case 1:
                
                lab1.textColor = UIColor.hexColor(0x1DD1A8)
                lab2.textColor = UIColor.hexColor(0x1DD1A8)
                dot1View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                dot2View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                line1View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                
            case 2:
                
                lab1.textColor = UIColor.hexColor(0x1DD1A8)
                lab2.textColor = UIColor.hexColor(0x1DD1A8)
                lab3.textColor = UIColor.hexColor(0x1DD1A8)
                
                dot1View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                dot2View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                dot3View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                
                line1View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                line2View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                
            case 3:
                
                lab1.textColor = UIColor.hexColor(0x1DD1A8)
                lab2.textColor = UIColor.hexColor(0x1DD1A8)
                lab4.textColor = UIColor.hexColor(0x1DD1A8)
                lab3.textColor = UIColor.hexColor(0x1DD1A8)
                
                dot1View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                dot2View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                dot3View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                dot4View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                
                line1View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                line2View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                line3View.backgroundColor = UIColor.hexColor(0x1DD1A8)
                
            default:
                break
            }
        }
    }
    
    override func makeUI() {
        super.makeUI()
        line4View.isHidden = true
        lab1.text = "出货中"
        lab2.text = "运输中"
        lab3.text = "配送中"
        lab4.text = "已签收"
        
        lab1.textColor = UIColor.hexColor(0xC8C8C8)
        lab2.textColor = UIColor.hexColor(0xC8C8C8)
        lab3.textColor = UIColor.hexColor(0xC8C8C8)
        lab4.textColor = UIColor.hexColor(0xC8C8C8)
        
        dot1View.backgroundColor = UIColor.hexColor(0xC8C8C8)
        dot2View.backgroundColor = UIColor.hexColor(0xC8C8C8)
        dot3View.backgroundColor = UIColor.hexColor(0xC8C8C8)
        dot4View.backgroundColor = UIColor.hexColor(0xC8C8C8)
        
        line1View.backgroundColor = UIColor.hexColor(0xC8C8C8)
        line2View.backgroundColor = UIColor.hexColor(0xC8C8C8)
        line3View.backgroundColor = UIColor.hexColor(0xC8C8C8)

        dot1View.cuttingCorner(radius: dotViewH/2)
        dot2View.cuttingCorner(radius: dotViewH/2)
        dot3View.cuttingCorner(radius: dotViewH/2)
        dot4View.cuttingCorner(radius: dotViewH/2)
    }
    
    override func updateUI() {
        
        dot1View.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(30)
            make.width.height.equalTo(dotViewH)
        }
        
        dot2View.snp.makeConstraints { (make) in
            make.left.equalTo(dot1View.snp.right).offset((kScreenW-108)/3-6)
            make.centerY.equalTo(dot1View)
            make.width.height.equalTo(dotViewH)
        }
        
        dot3View.snp.makeConstraints { (make) in
            make.left.equalTo(dot2View.snp.right).offset((kScreenW-108)/3-6)
            make.centerY.equalTo(dot1View)
            make.width.height.equalTo(dotViewH)
        }
        
        dot4View.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-30)
            make.width.height.equalTo(dotViewH)
        }
        
        line1View.snp.makeConstraints { (make) in
            make.left.equalTo(dot1View.snp.right).offset(5)
            make.centerY.equalTo(dot1View)
            make.right.equalTo(dot2View.snp.left).offset(-5)
            make.height.equalTo(1)
        }

        line2View.snp.makeConstraints { (make) in
            make.left.equalTo(dot2View.snp.right).offset(5)
            make.centerY.equalTo(dot1View)
            make.right.equalTo(dot3View.snp.left).offset(-5)
            make.height.equalTo(1)
        }

        line3View.snp.makeConstraints { (make) in
            make.left.equalTo(dot3View.snp.right).offset(5)
            make.centerY.equalTo(dot1View)
            make.right.equalTo(dot4View.snp.left).offset(-5)
            make.height.equalTo(1)
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
