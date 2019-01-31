//
//  FarmNonmembersHeaderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class FarmNonmembersHeaderView: UIView {

    lazy var topImg: ImageView = {
        let img = ImageView(image: UIImage(named: "farm_nonmembers"))
        img.backgroundColor = Color.whiteColor
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var titleLab: Label = {
        let lab = Label(nums: 0)
        lab.text = FarmNonmembersHeaderView.title
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.boldSystemFont(ofSize: 20)
        return lab
    }()
    
    lazy var detailLab1: Label = {
        let lab = Label(nums: 0)
        lab.text = FarmNonmembersHeaderView.detail1
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 14)
        return lab
    }()
    
    lazy var detailLab2: Label = {
        let lab = Label(nums: 0)
        lab.text = FarmNonmembersHeaderView.detail2
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 14)
        return lab
    }()
    
    lazy var detailLab3: Label = {
        let lab = Label(nums: 0)
        lab.text = FarmNonmembersHeaderView.detail3
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 14)
        return lab
    }()
    
    lazy var detailLab4: Label = {
        let lab = Label(nums: 0)
        lab.text = FarmNonmembersHeaderView.detail4
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 14)
        return lab
    }()
    
    lazy var contentBtnView: View = {
        let view = View()
        view.backgroundColor = UIColor.hexColor(0x15C5A2, alpha: 0.4)
        return view
    }()
    
    lazy var sureBtn: Button = {
        let btn = Button()
        btn.setTitle("去选组土地", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        return btn
    }()
    
    lazy var lineView: View = {
        let view = View()
        view.backgroundColor = UIColor.hexColor(0xE5E5E5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        addSubview(topImg)
        addSubview(titleLab)
        addSubview(detailLab1)
        addSubview(detailLab2)
        addSubview(detailLab3)
        addSubview(detailLab4)
        addSubview(contentBtnView)
        contentBtnView.addSubview(sureBtn)
        addSubview(lineView)
        
        contentBtnView.cuttingCorner(radius: 22)
        sureBtn.cuttingCorner(radius: 20)
    }
    
    func updateUI() {
        
        topImg.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(290)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(topImg.snp.bottom).offset(20)
            make.left.equalTo(self).offset(20)
        }
        
        detailLab1.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
        }
        
        detailLab2.snp.makeConstraints { (make) in
            make.top.equalTo(detailLab1.snp.bottom).offset(15)
            make.left.equalTo(20)
            make.right.equalTo(self).offset(-20)
        }
        
        detailLab3.snp.makeConstraints { (make) in
            make.top.equalTo(detailLab2.snp.bottom).offset(15)
            make.left.equalTo(20)
            make.right.equalTo(self).offset(-20)
        }
        
        detailLab4.snp.makeConstraints { (make) in
            make.top.equalTo(detailLab3.snp.bottom).offset(15)
            make.left.equalTo(20)
            make.right.equalTo(self).offset(-20)
        }
        
        contentBtnView.snp.makeConstraints { (make) in
            make.top.equalTo(detailLab4.snp.bottom).offset(30)
            make.left.equalTo(self).offset(50)
            make.right.equalTo(self).offset(-50)
            make.height.equalTo(44)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(contentBtnView).inset(2)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(contentBtnView.snp.bottom).offset(30)
            make.left.equalTo(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(1/2)
        }
        
    }
    
    func gradientBtn() {
        // fillCode
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 0.13, green: 0.83, blue: 0.69, alpha: 1).cgColor, UIColor(red: 0, green: 0.76, blue: 0.5, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = sureBtn.bounds
        bgLayer1.startPoint = CGPoint(x: 0, y: 0.5)
        bgLayer1.endPoint = CGPoint(x: 0.99, y: 0.5)
        sureBtn.layer.insertSublayer(bgLayer1, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
        gradientBtn()
        
        LogInfo("细线的y---\(lineView.y)")
        
    }


}

extension FarmNonmembersHeaderView {
    static let title = "值得您的选择："
    static let detail1 = "本农场土地是育土培土7年之久的优质黑土地"
    static let detail2 = "我们只采用天然的有机堆肥(草木灰、油枯、动物粪便等高温发酵而成)养育作物，含有有机物质，能提供农作物多种无机养分和有机养分，无毒无害无污染"
    static let detail3 = "我们采用地下50米深水水源灌溉庄稼，保证了水源的无污染，更是富含各种矿物质。"
    static let detail4 = "设备24小时视监测土地及蔬菜数据并及时反馈。 可一键浇水、施肥、除虫、除草。 蔬菜成熟之际，点击收菜即可新鲜配送到家"
}
