//
//  MineWalletHeaderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineWalletHeaderView: View {

    let contView = View()
    
    let titleLab = Label().then { (lab) in
        lab.text = "峻铭健康"
        lab.textColor = UIColor.white
        lab.textAlignment = .left
        lab.font = UIFont.systemFont(ofSize: 16)
    }
    
    let balanceLab = Label().then { (lab) in
        lab.text = "¥"
        lab.textColor = UIColor.white
        lab.textAlignment = .left
        lab.font = UIFont.boldSystemFont(ofSize: 40)
    }
    
    let tipsLab = Label().then { (lab) in
        lab.text = "账单"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.textAlignment = .left
        lab.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    let chongzhiBtn = Button().then { (btn) in
        btn.setTitle("充值", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setupBorder(width: 1, color: UIColor.white)
        btn.cuttingCorner(radius: 20)
    }
    
    override func makeUI() {
        super.makeUI()
        
        addSubview(contView)
        addSubview(tipsLab)
        
        contView.addSubview(titleLab)
        contView.addSubview(balanceLab)
        contView.addSubview(chongzhiBtn)
        
    }
    
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(12)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(123)
        }
        
        tipsLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.bottom.equalTo(self)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(17)
        }
        
        balanceLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(titleLab.snp.bottom)
        }
        
        chongzhiBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(72)
            make.height.equalTo(36)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // fillCode
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.92, blue: 0.64, alpha: 1).cgColor, UIColor(red: 1, green: 0.83, blue: 0.31, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = contView.bounds
        bgLayer1.startPoint = CGPoint(x: 1, y: 0.5)
        bgLayer1.endPoint = CGPoint(x: 0.5, y: 0.5)
        bgLayer1.cornerRadius = 10
        contView.layer.insertSublayer(bgLayer1, at: 0)
        
        // shadowCode
        contView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        contView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contView.layer.shadowOpacity = 1
        contView.layer.shadowRadius = 6
        contView.layer.cornerRadius = 10
        
    }
   
    /// - Public methods
    class func loadView() -> MineWalletHeaderView {
        let view = MineWalletHeaderView()
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 195)
        view.backgroundColor = Color.whiteColor
        return view
    }
    
}
