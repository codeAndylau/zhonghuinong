//
//  GoodsDetailHeaderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/20.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import SnapKit

let GoodsDetailBannerH: CGFloat = 300
let GoodsDetailHeaderH: CGFloat = 700

class GoodsDetailHeaderView: View {

    var bannerView = BannerView().then { (view) in
        view.pagerView.autoScrollInterval = 0
        view.pageControl.isHidden = true
    }
    
    let pageLab = Label().then { (lab) in
        lab.backgroundColor = UIColor.gray
        lab.text = "1/5"
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textAlignment = .center
    }
    
    let topView = GoodsDetailHeaderOneView.loadView()
    
    let bottomView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xFAFAFA)
    }
    
    let selectView = GoodsDetailRowView()
    let peisongView = GoodsDetailRowView()
    let yunfeiView = GoodsDetailRowView()

    override func makeUI() {
        super.makeUI()
        addSubview(bannerView)
        addSubview(pageLab)
        addSubview(topView)
        addSubview(bottomView)
        
        bottomView.addSubview(selectView)
        bottomView.addSubview(peisongView)
        bottomView.addSubview(yunfeiView)
    }
    
    override func updateUI() {
        super.updateUI()
        bannerView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(GoodsDetailBannerH)
        }
        
        pageLab.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(bannerView)
            make.width.equalTo(50)
            make.height.equalTo(18)
        }
        
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(bannerView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(200)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(200)
        }
        
        selectView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(54)
        }
        
        peisongView.snp.makeConstraints { (make) in
            make.top.equalTo(selectView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(54)
        }
        
        yunfeiView.snp.makeConstraints { (make) in
            make.top.equalTo(peisongView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(54)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pageLab.cuttingAnyCorner(roundingCorners: .topLeft, corner: 11)
    }
    
}
