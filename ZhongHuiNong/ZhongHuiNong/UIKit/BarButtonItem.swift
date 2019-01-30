//
//  BarButtonItem.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class BarButtonItem: UIBarButtonItem {

    convenience init(image: UIImage, target: Any, action: Selector) {
        self.init(image: image, style: UIBarButtonItem.Style.plain, target: target, action: action)
    }
    
}
