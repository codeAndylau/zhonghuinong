//
//  HotBottomView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/26.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class HotBottomView: View {

    let contView = View()
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xE5E5E5)
    }
    
    let sureBtn = Button().then { (btn) in
        btn.setTitle("去了解", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0xFF4D4F), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setupBorder(width: 1, color: UIColor.hexColor(0xFF4D4F))
        btn.cuttingCorner(radius: 20)
    }
    
    let priceView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xFF4D4F)
        view.cuttingCorner(radius: 20)
    }
    
    let priceLab = Label().then { (lab) in
        lab.text = "限时充值享会员特权9980"
        lab.textColor = UIColor.white
        lab.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let tipsLab = Label().then { (lab) in
        lab.text = "10000元"
        lab.textColor = UIColor.white
        lab.font = UIFont.boldSystemFont(ofSize: 9)
    }
    
    let priceBtn = Button()
    
    override func makeUI() {
        super.makeUI()
        
        addSubview(contView)
        
        contView.addSubview(lineView)
        contView.addSubview(sureBtn)
        contView.addSubview(priceView)
        contView.addSubview(priceBtn)
        
        priceView.addSubview(priceLab)
        priceView.addSubview(tipsLab)
    }
   
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(56)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        priceView.snp.makeConstraints { (make) in
            make.left.equalTo(sureBtn.snp.right).offset(12)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(40)
        }
        
        priceLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        tipsLab.snp.makeConstraints { (make) in
            make.left.equalTo(priceLab.snp.right).offset(5)
            make.bottom.equalTo(priceLab)
        }
        
        priceBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(priceView)
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // fillCode
//        let bgLayer1 = CAGradientLayer()
//        bgLayer1.colors = [UIColor(red: 1, green: 0.52, blue: 0.53, alpha: 1).cgColor,
//                           UIColor(red: 1, green: 0.3, blue: 0.31, alpha: 1).cgColor]
//        bgLayer1.locations = [0, 1]
//        bgLayer1.frame = priceView.bounds
//        bgLayer1.startPoint = CGPoint(x: 1, y: 0.5)
//        bgLayer1.endPoint = CGPoint(x: 0.5, y: 0.5)
//        priceView.layer.insertSublayer(bgLayer1, at: 0)
        
        // shadowCode
//        priceView.layer.shadowColor = UIColor.orange.cgColor  //(red: 1, green: 0.3, blue: 0.31, alpha: 0.4).cgColor
//        priceView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        priceView.layer.shadowOpacity = 1
//        priceView.layer.shadowRadius = 5
//        priceView.layer.masksToBounds = true
    }

    /// - Public methods
    class func loadView() -> HotBottomView {
        let view = HotBottomView(frame: CGRect(x: 0, y: kScreenH-kBottomViewH, width: kScreenW, height: kBottomViewH))
        view.backgroundColor = Color.whiteColor
        return view
    }
}
