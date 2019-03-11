//
//  GoodsDetailFooterView.swift
//  ZhongHuiNong
//
//  Created by lau Andy on 2019/3/12.
//  Copyright © 2019年 Andylau. All rights reserved.
//

import UIKit

class GoodsDetailFooterView: View {

    var loading:UIActivityIndicatorView!
    
    override func makeUI() {
        backgroundColor = Color.themeColor
        self.loading =  UIActivityIndicatorView(style: .gray)
        self.addSubview(self.loading)
        self.loading.startAnimating()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.loading.center = self.center
    }
    
    class func loadView() -> GoodsDetailFooterView {
        let view = GoodsDetailFooterView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 200))
        return view
    }

}
