//
//  Configs.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

struct Configs {
    
    struct App {
        static let bundleIdentifier = "com.public.SwiftHub"
        static let IsTesting = true
    }
    
    struct Network {
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
}
