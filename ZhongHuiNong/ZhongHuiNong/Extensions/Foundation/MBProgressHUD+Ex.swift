//
//  MBProgressHUD+Ex.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/4.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {
    
    //显示等待消息
    class func showWait(_ title: String) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
    }
    
    //显示普通消息
    class func showInfo(_ title: String, animationType: MBProgressHUDAnimation = .fade) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.animationType = animationType
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        hud.isUserInteractionEnabled = false
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "notice_bar_info")!) //自定义视图显示图片
        hud.label.text = title
        hud.label.textColor = UIColor.white
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    //显示成功消息
    class func showSuccess(_ title: String, animationType: MBProgressHUDAnimation = .fade) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.animationType = animationType
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        hud.isUserInteractionEnabled = false
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "notice_bar_success")!) //自定义视图显示图片
        hud.label.text = title
        hud.label.textColor = UIColor.white
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    //显示失败消息
    class func showError(_ title: String, animationType: MBProgressHUDAnimation = .fade) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.animationType = animationType
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        hud.isUserInteractionEnabled = false
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "notice_bar_error")!) //自定义视图显示图片
        hud.label.text = title
        hud.label.textColor = UIColor.white
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    //获取用于显示提示框的view
    class func viewToShow() -> UIView {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windowArray = UIApplication.shared.windows
            for tempWin in windowArray {
                if tempWin.windowLevel == UIWindow.Level.normal {
                    window = tempWin;
                    break
                }
            }
        }
        return window!
    }
    
    //隐藏hud
    class func hideHud() {
        MBProgressHUD.hide(for: viewToShow(), animated: true)
    }

}
