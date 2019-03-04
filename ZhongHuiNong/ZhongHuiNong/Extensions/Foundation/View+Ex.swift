//
//  View.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import SnapKit

extension ConstraintView {
    var usnp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}

extension UIView {
    /// 为视图添加弱网效果
    ///
    /// - Parameter isWindless: 是否为弱网状态
    func windless(isWindless: Bool) {
        var windLessView: UIView? = self.viewWithTag(Configs.Network.kWindlessViewTag)
        if isWindless {
            if windLessView == nil {
                // 添加弱网视图
                windLessView = UIView(frame: self.bounds)
                windLessView!.backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
                windLessView?.layer.position    = CGPoint(x: 0, y: 0)
                windLessView?.layer.anchorPoint = CGPoint(x: 0, y: 0)
                windLessView!.tag = Configs.Network.kWindlessViewTag
                self.addSubview(windLessView!)
            }
            // 添加动画
            let random = CGFloat(self.randomNum(start: 4, end: 6)) / 10.0
            let minW = self.bounds.size.width * random
            let maxW = self.bounds.size.width * 1.0
            let animation = CABasicAnimation(keyPath: "bounds.size.width")
            animation.duration      = 1
            animation.repeatCount   = MAXFLOAT
            animation.autoreverses  = true
            animation.fromValue     = CGFloat(minW)
            animation.toValue       = CGFloat(maxW)
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            windLessView!.layer.add(animation, forKey: "WindlessAnimation")
        } else {
            guard windLessView != nil else {
                return
            }
            // 移除弱网视图
            windLessView?.removeFromSuperview()
        }
    }
        /// 获取（start~end）的随机数(为了让动画更好看)
        func randomNum(start: Int, end: Int) -> Int {
            var temp = Int(arc4random_uniform(UInt32(end))) + 1
            if temp < start {
                temp = self.randomNum(start: start, end: end)
            }
            return temp
        }
}

// 给试图添加唯一表示
extension UIView {
    
    struct Static {
        static var key = "key"
    }
    
    var viewIdentifier: String? {
        get {
            return objc_getAssociatedObject( self, &Static.key ) as? String
        }
        set {
            objc_setAssociatedObject(self, &Static.key, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

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
