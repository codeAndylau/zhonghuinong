//
//  Label.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class Label: UILabel {

    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - convenience
    
    convenience init(nums: Int) {
        self.init()
        self.numberOfLines = nums
    }
    
    convenience init(title: String, font: CGFloat) {
        self.init()
        self.text = title
        self.font = UIFont.systemFont(ofSize: font)
    }
    
    convenience init(title: String, color: UIColor, font: CGFloat) {
        self.init()
        self.text = title
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: font)
    }
    
}

extension Label {

    func makeUI() {
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
}

extension Label {
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    var leftTextInset: CGFloat {
        set { textInsets.left = newValue }
        get { return textInsets.left }
    }
    
    var rightTextInset: CGFloat {
        set { textInsets.right = newValue }
        get { return textInsets.right }
    }
    
    var topTextInset: CGFloat {
        set { textInsets.top = newValue }
        get { return textInsets.top }
    }
    
    var bottomTextInset: CGFloat {
        set { textInsets.bottom = newValue }
        get { return textInsets.bottom }
    }
}
