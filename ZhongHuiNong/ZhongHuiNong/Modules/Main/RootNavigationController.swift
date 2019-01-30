//
//  RootNavigationController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/24.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import RTRootNavigationController

class RootNavigationController: RTRootNavigationController {
    
    var currentVC: UIViewController?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return globalStatusBarStyle.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationBar.backIndicatorImage = RootNavigationController.navigation_back_icon
        //navigationBar.backIndicatorTransitionMaskImage = RootNavigationController.navigation_back_icon
        self.interactivePopGestureRecognizer?.delegate = self
        
        globalStatusBarStyle.mapToVoid().subscribe(onNext: { [weak self] () in
            self?.setNeedsStatusBarAppearanceUpdate()
        }).disposed(by: rx.disposeBag)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            let navigation_back_icon = UIImage(named: "navigation_back_icon")!
            viewController.navigationItem.leftBarButtonItem = BarButtonItem(image: navigation_back_icon, target: self, action: #selector(popAction))
            viewController.hidesBottomBarWhenPushed = true
        }
        // 这句super要写在后面，让viewController可以覆盖上面设置的leftBarButtonItem
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func popAction() {
        self.popViewController(animated: true)
    }
    
}

extension RootNavigationController: UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        if navigationController.viewControllers.count == 1 {
            self.currentVC = nil
        }else{
            self.currentVC = viewController
        }
        
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            return self.currentVC == self.topViewController
        }
        return true
    }
    
}
