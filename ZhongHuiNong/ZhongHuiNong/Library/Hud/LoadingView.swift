//
//  FlashLoadingView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/28.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class LoadingView: View {

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
    
    class func loadView() -> LoadingView {
        let view = LoadingView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH))
        return view
    }
    
    // 隐藏 HUD
    class func hideHUD(view: UIView?) {
        var tempView = view
        if tempView == nil {
            tempView = UIApplication.shared.windows.last
        }
        guard let view = tempView else {
            debugPrints("没有获取到tempView")
            return
        }
        guard let hud = self.getHUD(From: view) else {
            debugPrints("没有获取到hud")
            return
        }
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            hud.imageView.alpha = 0.1
            hud.alpha = 0.1
        }) { (_) in
            hud.removeFromSuperview()
        }
    }

    // 获取 view 上的 HUD
    class func getHUD(From view: UIView) -> LoadingView? {
        for view in view.subviews {
            if view.isKind(of: self){
                return view as? LoadingView
            }
        }
        return nil
    }
}
