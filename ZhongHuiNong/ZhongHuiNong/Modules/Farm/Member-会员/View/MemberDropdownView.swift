//
//  MemberDropdownView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/15.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MemberDropdownView: View {
    
    let cardView = MemberDropdownSubView().then { (view) in
        view.leftImg.image = UIImage(named: "farm_liping")
        view.titleLab.text = "礼品卡激活"
        view.detailLab.text = "峻铭健康礼品卡激活"
    }
    
    let scanView = MemberDropdownSubView().then { (view) in
        view.leftImg.image = UIImage(named: "farm_scan")
        view.titleLab.text = "扫码溯源"
        view.detailLab.text = "扫码溯源，追溯商品各个环节，安全保障"
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF5F5F5)
    }
    
    
    override func makeUI() {
        super.makeUI()
        addSubview(cardView)
        addSubview(scanView)
        addSubview(lineView)
    }
    
    override func updateUI() {
        super.updateUI()
        cardView.snp.makeConstraints { (make) in
            make.left.top.width.equalTo(self)
            make.height.equalTo(80)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(cardView.snp.bottom)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(1)
        }
        
        scanView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom)
            make.left.width.equalTo(self)
            make.height.equalTo(80)
        }
    }
    
    /// - Public methods
    class func loadView() -> MemberDropdownView {
        let view = MemberDropdownView()
        view.frame = CGRect(x: 0, y: kScreenH-500, width: kScreenW, height: 161)
        //let corners: UIRectCorner = [.topLeft, .topRight]
        //view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }
    
}


class MemberDropdownSubView: Button {
    
    let leftImg = ImageView().then { (img) in
        img.image = UIImage(named: "mine_default_ portrait")
    }
    
    
    let titleLab = Label().then { (lab) in
        lab.text = "礼品卡激活"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 18)
    }
    
    let detailLab = Label().then { (lab) in
        lab.text = "峻铭健康礼品卡激活"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(leftImg)
        addSubview(titleLab)
        addSubview(detailLab)
    }
    
    override func updateUI() {
        super.updateUI()
        leftImg.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(58)
            make.top.equalTo(self).offset(15)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(8)
        }
    }
}
