//
//  ViewController+Ex.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/15.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWithTitle(title: String, message: String, openSettingsURLString: String, isShowOKBtn: Bool) -> Void {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        if !openSettingsURLString.isEmpty {
            let settingAction = UIAlertAction.init(title: "去设置", style: .destructive, handler: { (action) in
                let url = URL(string: openSettingsURLString)
                if let url = url, UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: {(success) in})
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            })
            alertController.addAction(settingAction)
        }
        if (isShowOKBtn) {
            let okAction = UIAlertAction.init(title: "好", style: .cancel, handler: nil)
            alertController.addAction(okAction)
        }
        present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    var topMost: UIViewController? {
        var rootViewController: UIViewController?
        for window in UIApplication.shared.windows where !window.isHidden {
            if let windowRootViewController = window.rootViewController {
                rootViewController = windowRootViewController
                break
            }
        }
        return self.topMost(of: rootViewController)
    }
    
    func topMost(of viewController: UIViewController?) -> UIViewController? {
        
        // presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            return self.topMost(of: presentedViewController)
        }
        
        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return self.topMost(of: selectedViewController)
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.topMost(of: visibleViewController)
        }
        
        // UIPageController
        if let pageViewController = viewController as? UIPageViewController,
            pageViewController.viewControllers?.count == 1 {
            return self.topMost(of: pageViewController.viewControllers?.first)
        }
        
        // child view controller
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return self.topMost(of: childViewController)
            }
        }
        return viewController
    }
}

extension UIViewController {
    
    // Get ViewController in top present level
    var topPresentedViewController: UIViewController? {
        var target: UIViewController? = self
        while (target?.presentedViewController != nil) {
            target = target?.presentedViewController
        }
        return target
    }
    
    // Get top VisibleViewController from ViewController stack in same present level.
    // It should be visibleViewController if self is a UINavigationController instance
    // It should be selectedViewController if self is a UITabBarController instance
    var topVisibleViewController: UIViewController? {
        if let navigation = self as? UINavigationController {
            if let visibleViewController = navigation.visibleViewController {
                return visibleViewController.topVisibleViewController
            }
        }
        if let tab = self as? UITabBarController {
            if let selectedViewController = tab.selectedViewController {
                return selectedViewController.topVisibleViewController
            }
        }
        return self
    }
    
    // Combine both topPresentedViewController and topVisibleViewController methods, to get top visible viewcontroller in top present level
    var topMostViewController: UIViewController? {
        return self.topPresentedViewController?.topVisibleViewController
    }
}


// 系统提示框
extension UIViewController {
    
    // MARK: - Alert Style
    public func showAlertWithTitle(_ title: String?) {
        showAlert(title, message: nil, cancelButtonTitle: "OK")
    }
    
    public func showAlertWithMessage(_ message: String?) {
        showAlert("", message: message, cancelButtonTitle: "OK")
    }
    
    public func showAlert(_ title: String?, message: String?, cancelButtonTitle: String) {
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
        showAlert(title, message: message, alertActions: [cancelAction])
    }
    
    public func showAlert(_ title: String?, message: String?, alertActions: [UIAlertAction]) {
        showAlert(title, message: message, preferredStyle: .alert, alertActions: alertActions)
    }
    
    // MARK: - Action Sheet Style
    
    public func showActionSheetWithTitle(_ title: String?) {
        showActionSheet(title, message: nil, cancelButtonTitle: "OK")
    }
    
    
    public func showActionSheetWithMessage(_ message: String?) {
        showActionSheet(nil, message: message, cancelButtonTitle: "OK")
    }
    
    public func showActionSheet(_ title: String?, message: String?) {
        showActionSheet(title, message: message, cancelButtonTitle: "OK")
    }
    
    public func showActionSheet(_ title: String?, message: String?, cancelButtonTitle: String) {
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
        showActionSheet(title, message: message, alertActions: [cancelAction])
    }
    
    public func showActionSheet(_ title: String?, message: String?, alertActions: [UIAlertAction]) {
        showAlert(title, message: message, preferredStyle: .actionSheet, alertActions: alertActions)
    }
    
    // MARK: - Common Methods
    
    public func showAlert(_ title: String?, message: String?, preferredStyle: UIAlertController.Style, alertActions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for alertAction in alertActions {
            alertController.addAction(alertAction)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
