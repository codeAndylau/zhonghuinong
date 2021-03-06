//
//  File.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/6.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import Kingfisher

class PlaceholderView: View {
    
    var loading:UIActivityIndicatorView!
    
    override func makeUI() {
        backgroundColor = Color.backdropColor
        self.loading =  UIActivityIndicatorView(style: .gray)
        self.addSubview(self.loading)
        self.loading.startAnimating()
        self.loading.center = self.center
    }
    
}

extension PlaceholderView: Placeholder {}

// MARK: 对图片加载进行一次封装，现在使用 Kingfisher
extension UIImageView {
    
    func lc_setImageWithCustom(with url: String?, placeholderImage placeholder: View = PlaceholderView()) {
        self.kf.setImage(with: URL(string: url ?? ""), placeholder: PlaceholderView(), options: [.transition(.fade(0.3))])
    
    }
    
    /// 加载本地图片
    func lc_setLocalImage(with url: String) {
        self.image = UIImage(named: url)
    }
    
    /// 原图片
    func lc_setImage(with url: String?, placeholderImage placeholder: UIImage? = placeHolder, isAnimate: Bool = true) {
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
