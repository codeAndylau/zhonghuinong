//
//  MineOrderTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineOrderTabCell: TableViewCell, TabReuseIdentifier {
    
    let contView = View().then { (view) in
        view.backgroundColor = UIColor.white
        view.cuttingCorner(radius: 10)
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "峻铭自营"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.textAlignment = .left
        lab.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    let arrowImg = ImageView().then { (img) in
        img.image = UIImage(named: "farm_arrow")
    }
    
    let statusLab = Label().then { (lab) in
        lab.text = ""
        lab.textColor = UIColor.hexColor(0x1DD1A8)
        lab.textAlignment = .left
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let timeLab = Label().then { (lab) in
        lab.text = ""
        lab.textColor = UIColor.hexColor(0xC8C8C8)
        lab.textAlignment = .left
        lab.font = UIFont.systemFont(ofSize: 10)
    }

    let vegetablesView = VegetablesView()
    
    let moneyLab = Label().then { (lab) in
        lab.text = "0.0"
        lab.textColor = UIColor.hexColor(0x1DD1A8)
        lab.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let tipsLab = Label().then { (lab) in
        lab.text = "实付："
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let numLab = Label().then { (lab) in
        lab.text = ""
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func makeUI() {
        super.makeUI()
        selectionStyle = .none
        backgroundColor = UIColor.hexColor(0xFAFAFA)
        addSubview(contView)
        contView.addSubview(titleLab)
        contView.addSubview(arrowImg)
        contView.addSubview(statusLab)
        contView.addSubview(timeLab)
        contView.addSubview(vegetablesView)
        contView.addSubview(moneyLab)
        contView.addSubview(tipsLab)
        contView.addSubview(numLab)
    }
    
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 10, left: 12, bottom: 0, right: 12))
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(12)
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right).offset(6)
            make.centerY.equalTo(titleLab)
        }
        
        statusLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.right.equalTo(statusLab.snp.left).offset(-10)
            make.centerY.equalTo(statusLab)
        }
        
        vegetablesView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(50)
        }
        
        moneyLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        tipsLab.snp.makeConstraints { (make) in
            make.right.equalTo(moneyLab.snp.left)
            make.centerY.equalTo(moneyLab)
        }
        
        numLab.snp.makeConstraints { (make) in
            make.right.equalTo(tipsLab.snp.left).offset(-6)
            make.centerY.equalTo(tipsLab)
        }
        
    }
    
    var order: MineGoodsOrderInfo = MineGoodsOrderInfo() {
        didSet {
            
            numLab.text = "共\(order.orderGoodsList.count)件"
            
            statusLab.text = "已取消"
            statusLab.textColor = UIColor.hexColor(0x999999)
            
            if order.add_time.components(separatedBy: "T").count > 1 {
                timeLab.text = order.add_time.components(separatedBy: "T")[0]
            }else {
                timeLab.text = order.add_time
            }
            
            for item in order.orderGoodsList.enumerated() {
                
                debugPrints("商品图片信息---\(item.element.goodsPic)")
                
                
                vegetablesView.btn1.image = UIImage()
                vegetablesView.btn2.image = UIImage()
                vegetablesView.btn3.image = UIImage()
                vegetablesView.btn4.image = UIImage()
                vegetablesView.btn5.image = UIImage()
                
                
                if item.offset == 0 {
                    vegetablesView.btn1.lc_setImage(with: item.element.goodsPic)
                }
                
                if item.offset == 1 {
                    vegetablesView.btn2.lc_setImage(with: item.element.goodsPic)
                }
                
                if item.offset == 2 {
                    vegetablesView.btn3.lc_setImage(with: item.element.goodsPic)
                }
                
                if item.offset == 3 {
                    vegetablesView.btn4.lc_setImage(with: item.element.goodsPic)
                }
                
                if item.offset == 4 {
                    vegetablesView.btn5.lc_setLocalImage(with: "mine_order_omit")
                }
                
            }
            
            var price: CGFloat = 0
            order.orderGoodsList.forEach { (item) in
                price += item.goodsPrice * CGFloat(item.quantity)
            }
            
            moneyLab.text = "\(price)"
        }
    }

}
