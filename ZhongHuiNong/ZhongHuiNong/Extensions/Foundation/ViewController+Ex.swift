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
    
    var topPresentedViewController: UIViewController? {
        var target: UIViewController? = self
        while (target?.presentedViewController != nil) {
            target = target?.presentedViewController
        }
        return target
    }
    
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
