//
//  View.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

extension UIView {
    
    func cuttingCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        
        /*
         clipsToBounds(UIView): 是指视图上的子视图,如果超出父视图的部分就截取掉
         masksToBounds(CALayer): 却是指视图的图层上的子图层,如果超出父图层的部分就截取掉
         */
    }
    
    func setupBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    /// 砌任意圆角
    func cuttingAnyCorner(roundingCorners: UIRectCorner, corner: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: corner, height: corner))
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = self.bounds
        cornerLayer.path = path.cgPath
        self.layer.mask = cornerLayer
    }
    
    /// 圆角和阴影同时
    func setupCornerAndBorder(radius: CGFloat, color: UIColor = UIColor.hexColor(0xECECEC), size: CGSize = CGSize(width: 4, height: 4), shadowOpacity: Float = 0.8, shadowRadius: CGFloat = 3) {
        
        layer.cornerRadius = radius // 如果view上面还有子试图的时候就要注意了 子试图也要进行切割
        
        layer.shadowColor = color.cgColor
        layer.shadowOffset = size
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
}


// 获取xyz
extension UIView {
    
    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
}
