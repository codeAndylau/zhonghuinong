//
//  GoodsDetailRightView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class GoodsDetailRightView: View {
    
    let homeBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_goods_home"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
    }
    
    let shareBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_goods_share"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
    }

    override func makeUI() {
        super.makeUI()
        addSubview(homeBtn)
        addSubview(shareBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        homeBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        shareBtn.frame = CGRect(x: 44, y:0 , width: 44, height: 44)
    }
    
    /// Public method
    class func loadView() -> GoodsDetailRightView {
        let view = GoodsDetailRightView(frame: CGRect(x: 0, y: 0, width: 88, height: 44))
        view.backgroundColor = UIColor.clear
        return view
    }

}
