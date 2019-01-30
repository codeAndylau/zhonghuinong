//
//  Color.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

extension UIColor {
    
    // 便利初始化方法
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }

    // Int64
    static func hexColor(_ hexColor : Int64, alpha: CGFloat = 1) -> UIColor {
        let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0;
        let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0;
        let blue = ((CGFloat)(hexColor & 0xFF))/255.0;
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 随机颜色
    static func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
}

/// 主题颜色
struct Color {
    static let whiteColor = UIColor.white
    static let themeColor = UIColor.hexColor(0x16C6A3)
    static let barTintColor = UIColor.hexColor(0xE5E5E5)
    static let barTitleColor = UIColor.hexColor(0x999999)
    static let backdropColor = UIColor.hexColor(0xf5f5f5)
    static let greyColor = UIColor.hexColor(0xA9A9A9)
    static let showImgColor = UIColor.hexColor(0xE5E5E5)
}



