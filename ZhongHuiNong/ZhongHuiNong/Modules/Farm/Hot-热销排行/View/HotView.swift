//
//  HotView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/26.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class HotView: View {
    
    override func makeUI() {
        super.makeUI()
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.44, blue: 0.26, alpha: 1).cgColor, UIColor(red: 1, green: 0.3, blue: 0.31, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = bounds
        bgLayer1.startPoint = CGPoint(x: 0, y: 0.5)
        bgLayer1.endPoint = CGPoint(x: 0.5, y: 0.5)
        layer.insertSublayer(bgLayer1, at: 0)
    }
    
    /// Public method
    class func loadView() -> HotView {
        let view = HotView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kNavBarH+44))
        return view
    }
}
