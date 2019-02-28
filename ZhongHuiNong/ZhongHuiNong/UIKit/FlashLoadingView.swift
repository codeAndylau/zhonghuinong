//
//  FlashLoadingView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/28.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

//class FlashLoadingView: View {
//
//    let contView = View().then { (view) in
//        view.backgroundColor = UIColor.darkGray
//    }
//
//    lazy var imageView: UIImageView = {
//        let imgV = UIImageView()
//        imgV.image = UIImage(named: "launch_icon")
//        imgV.frame = bounds
//        return imgV
//    }()
//
//
//    let gradientLayer: CAGradientLayer = {
//        let layer = CAGradientLayer()
//        layer.colors = [
//            UIColor.lightGray.cgColor,
//            UIColor.gray.cgColor,
//            UIColor.lightGray.cgColor
//        ]
//        layer.locations = [0, 0, 0.35]
//        layer.startPoint = CGPoint(x: 0.1, y: 0.6)
//        layer.endPoint = CGPoint(x: 0.9, y: 0.4)
//        return layer
//    }()
//
//    override func makeUI() {
//        super.makeUI()
//
//        contView.frame = CGRect(x: (kScreenW-112)/2, y: (kScreenH-30)/2, width: 112, height: 30)
//        imageView.frame = CGRect(x: 0, y: 0, width: 112, height: 30)
//
//        addSubview(contView)
//        contView.addSubview(imageView)
//
//        gradientLayer.frame = CGRect(x: 0, y: 0, width: 112, height: 30)
//        contView.layer.insertSublayer(gradientLayer, at: 0)
//
//        startAnimate()
//
//        //设置遮罩，让渐变层透过文字显示出来
//        contView.mask = imageView
//
//        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification).subscribe(onNext: { [weak self] (_) in
//            guard let self = self else { return }
//            self.startAnimate()
//        }).disposed(by: rx.disposeBag)
//
//    }
//
//
//    func startAnimate() {
//        //添加渐变动画（让白色光泽从左向右移动）
//        let gradientAnimation = CABasicAnimation(keyPath: "locations")
//        gradientAnimation.fromValue = [0, 0, 0.2]
//        gradientAnimation.toValue = [0.8, 1, 1]
//        gradientAnimation.duration = 2.5
//        gradientAnimation.repeatCount = HUGE
//        self.gradientLayer.add(gradientAnimation, forKey: nil)
//    }
//
//    /// Public method
//    class func loadView() -> FlashLoadingView {
//        let view = FlashLoadingView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH))
//        return view
//    }
//
//
//}

class FlashLoadingView: View {

    let contView = View().then { (view) in
        view.backgroundColor = UIColor.darkGray
    }
    
    let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        let colors = [
            UIColor.lightGray.cgColor,
            UIColor.gray.cgColor,
            UIColor.gray.cgColor,
            UIColor.lightGray.cgColor
        ]
        layer.colors = colors
        let locations: [NSNumber] = [
            -0.4,
            -0.39,
            -0.24,
            -0.23
        ]
        layer.locations = locations
        layer.startPoint = CGPoint(x: 0.1, y: 0.6)
        layer.endPoint = CGPoint(x: 1.0, y: 0.4)
        return layer
    }()
    
    lazy var imageView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "launch_icon")
        imgV.frame = bounds
        return imgV
    }()

    override func makeUI() {
        super.makeUI()
        addSubview(contView)
        contView.addSubview(imageView)
        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification).subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.startAnimate()
        }).disposed(by: rx.disposeBag)
    }

    override func layoutSubviews() {
        contView.frame = CGRect(x: (kScreenW-112)/2, y: (kScreenH-30)/2, width: 112, height: 30)
        imageView.frame = CGRect(x: 0, y: 0, width: 112, height: 30)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 112, height: 30)
        contView.mask = imageView
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        contView.layer.insertSublayer(gradientLayer, at: 0)
        startAnimate()
    }

    func startAnimate() {
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [-0.8,-0.79,-0.64,-0.63]
        gradientAnimation.toValue = [1.5,1.51,1.76,1.77]
        gradientAnimation.duration = 2.0
        gradientAnimation.repeatCount = MAXFLOAT
        gradientLayer.add(gradientAnimation, forKey: nil)
    }

    /// Public method
    class func loadView() -> FlashLoadingView {
        let view = FlashLoadingView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH))
        return view
    }

}
