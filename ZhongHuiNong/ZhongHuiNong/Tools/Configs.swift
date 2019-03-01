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
        static let debugUrl   = URL(string: "http://212.64.64.36:8080/")!   // 测试服务器
        static let releaseUrl = URL(string: "http://212.64.52.253:8080/")!  // 正是服务器
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
