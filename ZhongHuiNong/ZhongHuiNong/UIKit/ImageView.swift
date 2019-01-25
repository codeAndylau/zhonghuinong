//
//  ImageView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
