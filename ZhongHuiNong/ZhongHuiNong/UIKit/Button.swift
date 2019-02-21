//
//  Button.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init(title: String, color: UIColor, font: CGFloat) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: font)
    }
    
    convenience init(title: String, color: UIColor, img: String) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.setImage(UIImage(named: img), for: .normal)
    }
    
    convenience init(image: UIImage?, target: Any, action: Selector) {
        self.init()
        self.adjustsImageWhenHighlighted = false
        self.setImage(image, for: .normal)
        self.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }
    
    func makeUI() {
        
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
    
}
