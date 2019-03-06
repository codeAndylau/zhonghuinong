//
//  AnnularProgressBar.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/6.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 环形倒计时进度条
class AnnularProgressBar: UIView {
    
    /// 进度条颜色
    var strokeColor: UIColor = #colorLiteral(red: 0, green: 0.8071675897, blue: 0.6995571256, alpha: 1) {
        didSet {
            shapeLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    /// 线款
    var lineHeight: CGFloat = 3 {
        didSet {
            trackLayer.lineWidth = lineHeight
            shapeLayer.lineWidth = lineHeight
        }
    }
    
    /// 进度
    var progress: Double = 0 {
        didSet {
            shapeLayer.strokeEnd = CGFloat(progress)
        }
    }
    
    /// 进度槽
    private var trackLayer: CAShapeLayer!
    
    /// 进度条
    private var shapeLayer: CAShapeLayer!
    
    lazy var titleLab = Label().then { (lab) in
        lab.text = ""
        lab.textColor = strokeColor
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer = createShapeLayer(strokeColor: UIColor.hexColor(0xECECEC), fillColor: .clear)
        trackLayer.strokeEnd = 1
        trackLayer.lineDashPhase = 1.0
        trackLayer.lineDashPattern = [2,1] // 线宽 和 间距
        layer.addSublayer(trackLayer)
        
        shapeLayer = createShapeLayer(strokeColor: strokeColor, fillColor: .clear)
        shapeLayer.lineDashPattern = [3,0]
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = CGFloat(progress)
        layer.addSublayer(shapeLayer)
        
        addSubview(titleLab)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cx = self.bounds.width / 2
        let cy = self.bounds.height / 2
        
        let viewCenter = CGPoint(x: cx, y: cy)
        
        let radius = min(cx, cy) - lineHeight
        
        let path = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        
        trackLayer.path = path.cgPath
        shapeLayer.path = path.cgPath
        
        trackLayer.position = viewCenter
        shapeLayer.position = viewCenter
        
        /// 旋转45度
        trackLayer.transform = CATransform3DMakeRotation(-.pi/2, 0, 0, 1)
        shapeLayer.transform = CATransform3DMakeRotation(-.pi/2, 0, 0, 1)
        
        titleLab.frame = frame
        
    }
    
    private func createShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.lineWidth = lineHeight
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        return layer
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
