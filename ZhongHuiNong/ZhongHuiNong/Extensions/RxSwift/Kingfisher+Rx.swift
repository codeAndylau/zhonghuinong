//
//  Kingfisher+Rx.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

extension Reactive where Base: UIImageView {
    
    var imageUrl: Binder<URL?> {
        return self.imageUrl(withPlaceholder: nil)
    }
    
    func imageUrl(withPlaceholder placeholderImage: UIImage?, options: KingfisherOptionsInfo? = []) -> Binder<URL?> {
        return Binder(self.base, binding: { (imageView, url) in
            imageView.kf.setImage(with: url,
                                  placeholder: placeholderImage,
                                  options: options,
                                  progressBlock: nil,
                                  completionHandler: { (image, error, type, url) in })
        })
    }
}
