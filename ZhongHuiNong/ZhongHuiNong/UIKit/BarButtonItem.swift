//
//  BarButtonItem.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class BarButtonItem: UIBarButtonItem {

    convenience init(image: UIImage?, target: Any, action: Selector) {
        self.init(image: image, style: UIBarButtonItem.Style.plain, target: target, action: action)
    }
    
    class func leftBarView() -> BarButtonItem {
        let view = FarmHeaderView.loadView()
        return BarButtonItem(customView: view)
    }
    
    class func cartItem() -> BarButtonItem {
        let lab = Label(title: "购物车", color: UIColor.black, boldFont: 20)
        return BarButtonItem(customView: lab)
    }
    
}
