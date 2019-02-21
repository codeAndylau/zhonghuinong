//
//  GoodsDetailBuyView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/20.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class GoodsDetailBuyView: View {

    let contentView = View().then { (view) in
        view.backgroundColor = Color.whiteColor
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xE5E5E5)
    }
    
    let caiLanBtn = Button(type: .custom).then { (btn) in
        btn.setImage(UIImage(named: "mine_goods_cailan"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
    }
    
    let collectionBtn = Button(type: .custom).then { (btn) in
        btn.setImage(UIImage(named: "mine_goods_collection"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
    }
    
    let buyBtn = Button(type: .custom).then { (btn) in
        btn.setTitle("立即购买", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x1DD1A8), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.adjustsImageWhenHighlighted = false
        btn.cuttingCorner(radius: 20)
        btn.setupBorder(width: 1, color: UIColor.hexColor(0x1DD1A8))
    }
    
    let cartBtn = Button(type: .custom).then { (btn) in
        btn.setTitle("加入购物车", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.adjustsImageWhenHighlighted = false
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
        btn.cuttingCorner(radius: 20)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(contentView)
        contentView.addSubview(lineView)
        contentView.addSubview(caiLanBtn)
        contentView.addSubview(collectionBtn)
        contentView.addSubview(buyBtn)
        contentView.addSubview(cartBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        contentView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(56)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        caiLanBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(56)
            make.height.equalTo(44)
        }
        
        collectionBtn.snp.makeConstraints { (make) in
            make.left.equalTo(caiLanBtn.snp.right)
            make.centerY.equalToSuperview()
            make.width.equalTo(56)
            make.height.equalTo(44)
        }
        
        buyBtn.snp.makeConstraints { (make) in
            make.left.equalTo(collectionBtn.snp.right)
            make.centerY.equalToSuperview()
            make.width.equalTo((kScreenW-155)/2)
            make.height.equalTo(40)
        }
        
        cartBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo((kScreenW-155)/2)
            make.height.equalTo(40)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // shadowCode
        cartBtn.layer.shadowColor = UIColor(red: 0.11, green: 0.82, blue: 0.66, alpha: 0.5).cgColor
        cartBtn.layer.shadowOffset = CGSize(width: 0, height: 3)
        cartBtn.layer.shadowOpacity = 1
        cartBtn.layer.shadowRadius = 5
    }
    
    /// Public method
    class func loadView() -> GoodsDetailBuyView {
        let viewH = IPhone_X == true ? 56 + kIndicatorH : 56
        let view = GoodsDetailBuyView(frame: CGRect(x: 0, y: kScreenH-viewH, width: kScreenW, height: viewH))
        return view
    }
    

}
