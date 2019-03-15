//
//  GoodsDetailHeaderOneView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/20.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class GoodsDetailHeaderOneView: View {

    let priceLab = Label().then { (lab) in
        lab.text = "¥98.6"
        lab.textColor = UIColor.hexColor(0x1DD1A8)
        lab.font = UIFont.boldSystemFont(ofSize: 26)
    }
    
    let nonPriceLab = Label().then { (lab) in
        lab.text = "¥169.9"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let jifenLab = Label().then { (lab) in
        lab.text = ""
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let memberView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xFFFAE9)
        view.cuttingCorner(radius: 15)
    }
    
    let vipImg = ImageView().then { (img) in
        img.image = UIImage(named: "mine_vip")
    }
    
    let vipLab = Label().then { (lab) in
        lab.text = "充值会员可享受超值价"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let vipChongzhiLab = Label().then { (lab) in
        lab.text = "" // 立即充值
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let vipArrowImg = ImageView().then { (img) in
        img.image = UIImage(named: "farm_arrow")
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "" // 新鲜红颜奶油草莓 约重1kg约30-40颗
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let detailLab = Label().then { (lab) in
        lab.text = ""
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.numberOfLines = 0
    }
    
    let suyuanBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "mine_suyuan"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xFAFAFA)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(priceLab)
        addSubview(nonPriceLab)
        addSubview(jifenLab)
        addSubview(memberView)
        
        memberView.addSubview(vipImg)
        memberView.addSubview(vipLab)
        memberView.addSubview(vipArrowImg)
        memberView.addSubview(vipChongzhiLab)
        
        addSubview(titleLab)
        addSubview(detailLab)
        addSubview(suyuanBtn)
        addSubview(lineView)
    }
  
    
    override func updateUI() {
        super.updateUI()
        
        priceLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(15)
            make.height.equalTo(31)
        }
        
        nonPriceLab.snp.makeConstraints { (make) in
            make.left.equalTo(priceLab.snp.right).offset(10)
            make.bottom.equalTo(priceLab).offset(-3)
        }
        
        jifenLab.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(nonPriceLab)
        }
        
        memberView.snp.makeConstraints { (make) in
            make.top.equalTo(priceLab.snp.bottom).offset(10)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(30)
        }
        
        vipImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(22)
            make.height.equalTo(15)
        }
        
        vipLab.snp.makeConstraints { (make) in
            make.left.equalTo(vipImg.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
        
        vipArrowImg.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
        
        vipChongzhiLab.snp.makeConstraints { (make) in
            make.right.equalTo(vipArrowImg.snp.left).offset(-8)
            make.centerY.equalToSuperview()
        }
        
        suyuanBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.top.equalTo(memberView.snp.bottom)
            make.width.equalTo(77)
            make.height.equalTo(79)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(memberView.snp.bottom).offset(15)
            make.right.lessThanOrEqualTo(suyuanBtn.snp.left).offset(-10)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.right.lessThanOrEqualTo(suyuanBtn.snp.left).offset(-10)
            make.bottom.lessThanOrEqualTo(lineView.snp.top).offset(-10)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(10)
        }
    }
    
    /// Public methods
    
    class func loadView() -> GoodsDetailHeaderOneView {
        let view = GoodsDetailHeaderOneView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 190))
        return view
    }
    
    var goodsDetailInfo: GoodsDetailInfo = GoodsDetailInfo() {
        didSet {
            priceLab.text = "¥\(goodsDetailInfo.salePrice)"
            nonPriceLab.text = "¥\(goodsDetailInfo.marketPrice)"
            titleLab.text = goodsDetailInfo.productName
            //detailLab.text = goodsDetailInfo.productName
        }
    }

}
