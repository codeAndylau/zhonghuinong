//
//  Configs.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import AdSupport

struct Configs {
    
    struct Constant {
        static let errorInfo = "请求数据失败"
    }
    
    struct Identifier {
        static let SettingPayPsd = "SettingPayPsd"
        static let WeChat_AppId = "wxaa1245f77008b79f"
        static let weChat_Secret = "047f3fab277cff56a56dd5ae8278b0f9"
        static let Bundle_ID = "com.cnkj.SmartFarm"
        static let EZ_AppKey = "ceb7361666b144d7985afbb1e1ceafaf"
        static let EZ_AccessToken = "at.2sumy0c6366ug2qr85c2hruj3mktxt7e-1scs0gkda7-190a2y1-0tjyxyp3h"
    }
    
    struct App {
        static let IsTesting = true
        static var appName: String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String }
        static var appVersion: String { return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String }
        static var appBuild: String { return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String }
        static var bundleIdentifier: String { return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String }
        static var bundleName: String { return Bundle.main.infoDictionary!["CFBundleName"] as! String }
        static var appStoreURL: URL { return URL(string: "your URL")! }
        static var appVersionAndBuild: String { return appVersion == appBuild ? "v\(appVersion)" : "v\(appVersion)(\(appBuild))" }
        static var IDFA: String { return ASIdentifierManager.shared().advertisingIdentifier.uuidString }
        static var IDFV: String { return UIDevice.current.identifierForVendor!.uuidString }
        static var screenOrientation: UIInterfaceOrientation { return UIApplication.shared.statusBarOrientation }
        static var screenStatusBarHeight: CGFloat { return UIApplication.shared.statusBarFrame.height }
    }
    
    struct Network {
        
        static let kWindlessViewTag = 91997
        static let loggingEnabled = false
        
        // 开发服务器
        static let smartFarmAPI01_dev = URL(string: "http://212.64.91.248:80/")!
        static let smartFarmAPI02_dev = URL(string: "https://api.smartfarm.villagetechnology.cn")!
        
        // 开发环境
        static let smartFarmAPI1_dev = URL(string: "http://devapi.smartfarm.villagetechnology.cn")!
        static let smartFarmAPI2_dev = URL(string: "https://devmxapi.smartfarm.villagetechnology.cn")!
        
        // 测试环境
        static let smartFarmAPI1_text = URL(string: "http://testapi.smartfarm.villagetechnology.cn")!
        static let smartFarmAPI2_text = URL(string: "https://testmxapi.smartfarm.villagetechnology.cn")!
        
        // 生产环境
        static let smartFarmAPI1_pro = URL(string: "https://proapi.smartfarm.villagetechnology.cn")!
        static let smartFarmAPI2_pro = URL(string: "https://promxapi.smartfarm.villagetechnology.cn")!
        
    }
    
    struct Size {
        static let left: CGFloat = 16
        static let inset: CGFloat = 10
        static let tabBarHeight: CGFloat = 58
        static let toolBarHeight: CGFloat = 66
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 1
        static let buttonHeight: CGFloat = 50
        static let textFieldHeight: CGFloat = 40
        static let tableRowHeight: CGFloat = 50
        static let tableHeaderHeight: CGFloat = 50
        static let segmentedControlHeight: CGFloat = 30
        static let navBarWithStatusBarHeight: CGFloat = 64
    }
    
    enum keyboardHeight: Int {
        case iphone6 = 216
        case iphone6p = 226
        case iphonex_s = 291
        case iphoner_max = 301
    }
}

public var topVC: UIViewController? {
    var rootViewController: UIViewController?
    for window in UIApplication.shared.windows where !window.isHidden {
        if let windowRootViewController = window.rootViewController {
            rootViewController = windowRootViewController
            break
        }
    }
    return topMost(of: rootViewController)
}

public func topMost(of viewController: UIViewController?) -> UIViewController? {
    
    if let presentedViewController = viewController?.presentedViewController {
        return topMost(of: presentedViewController)
    }
    
    if let tabBarController = viewController as? UITabBarController,
        let selectedViewController = tabBarController.selectedViewController {
        return topMost(of: selectedViewController)
    }
    
    if let navigationController = viewController as? UINavigationController,
        let visibleViewController = navigationController.visibleViewController {
        return topMost(of: visibleViewController)
    }
    
    if let pageViewController = viewController as? UIPageViewController,
        pageViewController.viewControllers?.count == 1 {
        return topMost(of: pageViewController.viewControllers?.first)
    }
    
    
    for subview in viewController?.view?.subviews ?? [] {
        if let childViewController = subview.next as? UIViewController {
            return topMost(of: childViewController)
        }
    }
    return viewController
}
