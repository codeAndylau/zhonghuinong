//
//  SearchTextField.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/14.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {

    // 光标
    override func caretRect(for position: UITextPosition) -> CGRect {
        var originalRect = super.caretRect(for: position)
        originalRect.origin.x = 11
        return originalRect
    }
    
    // 编辑的位置
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x - 11, y: bounds.origin.y , width: bounds.size.width - 50, height: bounds.size.height)
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 5, y: 8 , width: 17, height: 17)
    }

}
