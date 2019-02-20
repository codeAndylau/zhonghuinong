//
//  MemberXinpinCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MemberXinpinCell: TableViewCell, TabReuseIdentifier {

    lazy var bannerView = BannerView()
    
    lazy var zhigongImg = ImageView(image: UIImage(named: "farm_zhigong"))
    lazy var zhicaiImg = ImageView(image: UIImage(named: "farm_zhicai"))
    lazy var suyuanImg = ImageView(image: UIImage(named: "farm_suyuan"))
    lazy var yanjianImg = ImageView(image: UIImage(named: "farm_yanjian"))
    
    lazy var zhigongLab = Label(title: "农场直供", color: Color.themeColor, font: 10)
    lazy var zhicaiLab = Label(title: "全国直采", color: Color.themeColor, font: 10)
    lazy var suyuanLab = Label(title: "真实溯源", color: Color.themeColor, font: 10)
    lazy var yanjianLab = Label(title: "优选严检", color: Color.themeColor, font: 10)
    
    lazy var stackView1 = View()
    lazy var stackView2 = View()
    lazy var stackView3 = View()
    lazy var stackView4 = View()
    
    override func makeUI() {
        super.makeUI()
        addSubview(bannerView)
        addSubview(stackView1)
        addSubview(stackView2)
        addSubview(stackView3)
        addSubview(stackView4)
        
        stackView1.addSubview(zhigongImg)
        stackView1.addSubview(zhigongLab)
        
        stackView2.addSubview(zhicaiImg)
        stackView2.addSubview(zhicaiLab)
        
        stackView3.addSubview(suyuanImg)
        stackView3.addSubview(suyuanLab)
        
        stackView4.addSubview(yanjianImg)
        stackView4.addSubview(yanjianLab)
        
        bannerView.backgroundColor = Color.whiteColor
        
        bannerView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(self).offset(10)
            make.width.equalTo(kScreenW - 30)
            make.height.equalTo(155)
        }
        
        stackView1.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.top.equalTo(bannerView.snp.bottom).offset(5)
            make.width.equalTo((kScreenW-30)/4)
            make.height.equalTo(20)
        })
        
        stackView2.snp.makeConstraints({ (make) in
            make.left.equalTo(stackView1.snp.right)
            make.centerY.equalTo(stackView1)
            make.width.equalTo(stackView1.snp.width)
            make.height.equalTo(stackView1.snp.height)
        })
        
        stackView3.snp.makeConstraints({ (make) in
            make.left.equalTo(stackView2.snp.right)
            make.centerY.equalTo(stackView1)
            make.width.equalTo(stackView1.snp.width)
            make.height.equalTo(stackView1.snp.height)
        })
        
        stackView4.snp.makeConstraints({ (make) in
            make.left.equalTo(stackView3.snp.right)
            make.centerY.equalTo(stackView1)
            make.width.equalTo(stackView1.snp.width)
            make.height.equalTo(stackView1.snp.height)
        })
        
        zhigongImg.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        zhigongLab.snp.makeConstraints { (make) in
            make.left.equalTo(zhigongImg.snp.right).offset(3)
            make.centerY.equalToSuperview()
        }
        
        
        zhicaiImg.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        zhicaiLab.snp.makeConstraints { (make) in
            make.left.equalTo(zhicaiImg.snp.right).offset(3)
            make.centerY.equalToSuperview()
        }
        
        suyuanImg.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        suyuanLab.snp.makeConstraints { (make) in
            make.left.equalTo(suyuanImg.snp.right).offset(3)
            make.centerY.equalToSuperview()
        }
        
        yanjianImg.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        yanjianLab.snp.makeConstraints { (make) in
            make.left.equalTo(yanjianImg.snp.right).offset(3)
            make.centerY.equalToSuperview()
        }
    }

}
