//
//  MainTabBarViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    lazy var viewModel = MainTabbarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        
        viewModel.tabBarItems().drive(onNext: { [weak self] (item) in
            guard let self = self  else { return }
            let _ = item.map({ self.addChild($0.getController()) })
        }).disposed(by: rx.disposeBag)

    }
    
    // MARK: - Method
    
    func tabBarItemAnimate() {
        
        var tabBarButtons: [UIView] = []
        for tabbarBtn in self.tabBar.subviews {
            if tabbarBtn.isKind(of: NSClassFromString("UITabBarButton")!) {
                tabBarButtons.append(tabbarBtn)
            }
        }
        
        let tabbarBtn = tabBarButtons[self.selectedIndex] as! UIControl
        
        // imageView 需要实现的帧动画,这里根据自己需求改动
        for imageView in tabbarBtn.subviews {
            if imageView.isKind(of: NSClassFromString("UITabBarSwappableImageView")!) {
                let animation = CAKeyframeAnimation()
                animation.keyPath = "transform.scale"
                animation.values = [1.0, 1.15 , 0.95, 1.0]
                animation.duration = 0.3
                animation.calculationMode = CAAnimationCalculationMode.cubic
                imageView.layer.add(animation, forKey: nil)
            }
        }
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarItemAnimate()
        
        if tabBarController.selectedIndex == 2 {
            debugPrints("点击了tabbar的购物车按钮")
            NotificationCenter.default.post(name: NSNotification.Name.goodsDetailCartClicked, object: nil)
        }
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        //  只有在当前显示页时,再次点击首页 tabBarItem 才会执行刷新
        if tabBarController.selectedViewController!.isEqual(tabBarController.viewControllers![selectedIndex]) {
            if viewController.isEqual(tabBarController.selectedViewController) {
                debugPrints("点击的selectedIndex---\(selectedIndex)")
                return false
            }
        }
        return true
    }
    
}
