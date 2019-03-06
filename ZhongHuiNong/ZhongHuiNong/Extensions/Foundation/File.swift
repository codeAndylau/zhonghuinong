//
//  File.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/6.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import Kingfisher

public let placeHolder =  UIImage().getImageWithColor(color: UIColor.hexColor(0xf3f3f3))

// MARK: 对图片加载进行一次封装，现在使用 Kingfisher
extension UIImageView {
    
    /// 加载本地图片
    func lc_setLocalImage(with url: String) {
        self.image = UIImage(named: url)
    }
    
    /// 原图片
    func lc_setImage(with url: String?, placeholderImage placeholder: UIImage = placeHolder, isAnimate: Bool = true) {
        guard let url = url, let Url = URL(string: url) else {
            self.image = placeholder
            self.contentMode = .scaleAspectFill
            return
        }
        
        if isAnimate {
            self.kf.setImage(with: Url, placeholder: placeholder, options: [.transition(.fade(0.3))])
        }else {
            self.kf.setImage(with: Url, placeholder: placeholder)
        }
        
    }
    
}
