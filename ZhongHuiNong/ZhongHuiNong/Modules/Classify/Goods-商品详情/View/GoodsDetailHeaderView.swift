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
let GoodsDetailHeaderH: CGFloat = 750 - 130

class GoodsDetailHeaderView: View {

    var bannerView = BannerView().then { (view) in
        view.pagerView.autoScrollInterval = 0
        view.pageControl.isHidden = true
    }
    
    let pageLab = Label().then { (lab) in
        lab.backgroundColor = UIColor.hexColor(0x000000, alpha: 0.3)
        lab.text = "1/5"
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textAlignment = .center
    }
    
    let topView = GoodsDetailHeaderOneView.loadView().then { (view) in
        view.vipArrowImg.isHidden = true
    }
    
    let bottomView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xFAFAFA)
    }
    
    let selectView = GoodsDetailRowView().then { (view) in
        view.titleLab.text = "已选"
        view.detailLab.text = "500g x1"
        view.arrowImg.isHidden = true
    }
    
//
//    let peisongView = GoodsDetailRowView().then { (view) in
//        view.titleLab.text = "配送"
//        view.detailLab.text = "四川省成都市天府新区天府新区府河音乐花园A1-101"
//        view.lineView.isHidden = true
//    }
//
//    let addressView = GoodsDetailAddressView().then { (view) in
//        view.backgroundColor = UIColor.white
//    }
    
    let yunfeiView = GoodsDetailRowView().then { (view) in
        view.titleLab.text = "运费"
        view.detailLab.text = "会员免运费 非会员满98包邮"
        view.lineView.isHidden = true
        view.arrowImg.isHidden = true
    }

    override func makeUI() {
        super.makeUI()
        addSubview(bannerView)
        addSubview(pageLab)
        addSubview(topView)
        addSubview(bottomView)
        
        bottomView.addSubview(selectView)
        //bottomView.addSubview(peisongView)
        //bottomView.addSubview(addressView)
        bottomView.addSubview(yunfeiView)
        
        bannerView.didScrollFrom = { [weak self] index in
            guard let self = self else { return }
            self.pageLab.text = "\(index)/\(self.ImgArray.count)"
        }
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
            make.height.equalTo(120)
        }
        
        selectView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(55)
        }
        
//        peisongView.snp.makeConstraints { (make) in
//            make.top.equalTo(selectView.snp.bottom)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(55)
//        }
//
//        addressView.snp.makeConstraints { (make) in
//            make.top.equalTo(peisongView.snp.bottom)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(75)
//        }
        
        yunfeiView.snp.makeConstraints { (make) in
            make.top.equalTo(selectView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(55)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pageLab.cuttingAnyCorner(roundingCorners: .topLeft, corner: 11)
    }
    
    var ImgArray: [String] = []
    
    var goodsDetailInfo: GoodsDetailInfo = GoodsDetailInfo() {
        didSet {
            
            let bannerImg = goodsDetailInfo.albums
            bannerImg.forEach { (item) in
                
            }

            // 1. 上面轮播图
            
            if goodsDetailInfo.albums.count > 0 {
                pageLab.text = "1/\(goodsDetailInfo.albums.count)"
                for item in goodsDetailInfo.albums {
                    ImgArray.append(item.originalPath)
                }
            }else {
                pageLab.isHidden = true
            }
            
            
            bannerView.bannerArray.accept(ImgArray)
            
            // 2. 商品基本信息
            topView.goodsDetailInfo = goodsDetailInfo
            
            // 3 .商品已选规格
            selectView.detailLab.text = goodsDetailInfo.unit
            
        }
    }
    
}
