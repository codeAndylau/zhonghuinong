//
//  SettlementView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class SettlementView: View {

    lazy var lineView: View = {
        let view = View(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0.5))
        view.backgroundColor = UIColor.hexColor(0xE5E5E5)
        return view
    }()
    
    lazy var selectBtn: Button = {
        let btn = Button(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "store_jiahao"), for: .normal)
        return btn
    }()
    
    let selectLab = Label().then { (lab) in
        lab.text = "全选"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let totalLab = Label().then { (lab) in
        lab.text = "合计："
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    let memberPriceLab = Label().then { (lab) in
        lab.text = "¥388.0"
        lab.textColor = UIColor.hexColor(0x1DD1A8)
        lab.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let nonMemberPriceLab = Label().then { (lab) in
        lab.text = "¥1188.0"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    lazy var settlementBtn: Button = {
        let btn = Button(type: UIButton.ButtonType.custom)
        btn.setTitle("结算", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
        return btn
    }()
    
    override func makeUI() {
        super.makeUI()
        addSubview(lineView)
        addSubview(selectBtn)
        addSubview(selectLab)
        addSubview(totalLab)
        addSubview(memberPriceLab)
        addSubview(nonMemberPriceLab)
        addSubview(settlementBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        
        selectBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.width.height.equalTo(50)
        }
        
        selectLab.snp.makeConstraints { (make) in
            make.left.equalTo(selectBtn.snp.right)
            make.centerY.equalTo(self)
        }
        
        settlementBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        memberPriceLab.snp.makeConstraints { (make) in
            make.right.equalTo(settlementBtn.snp.left).offset(-10)
            make.top.equalTo(settlementBtn.snp.top)
        }
        
        nonMemberPriceLab.snp.makeConstraints { (make) in
            make.left.equalTo(memberPriceLab.snp.left)
            make.top.equalTo(memberPriceLab.snp.bottom).offset(5)
        }
        
        totalLab.snp.makeConstraints { (make) in
            make.right.equalTo(memberPriceLab.snp.left)
            make.centerY.equalTo(memberPriceLab)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // shadowCode
        settlementBtn.layer.shadowColor = UIColor(red: 0.11, green: 0.82, blue: 0.66, alpha: 0.5).cgColor
        settlementBtn.layer.shadowOffset = CGSize(width: 0, height: 3)
        settlementBtn.layer.shadowOpacity = 1
        settlementBtn.layer.shadowRadius = 5
        settlementBtn.layer.cornerRadius = 20
    }
    
    /// - Public methods
    class func loadView() -> SettlementView {
        let view = SettlementView()
        view.frame = CGRect(x: 0, y: kScreenH-kTabBarH-56, width: kScreenW, height: 56)
        view.backgroundColor = Color.whiteColor
        return view
    }

}
