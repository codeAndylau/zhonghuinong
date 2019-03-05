//
//  EZPlayerOrientation.swift
//  SmartVillage
//
//  Created by Andylau on 2018/11/27.
//  Copyright © 2018年 Andylau. All rights reserved.
//

import Foundation

enum EZPlayerOrientation: Int {
    
    case portrait
    case leftAndRight
    case all
    
    public func getOrientSupports() -> UIInterfaceOrientationMask {
        switch self {
        case .portrait:
            return [.portrait]
        case .leftAndRight:
            return [.landscapeLeft, .landscapeRight]
        case .all:
            return [.portrait, .landscapeLeft, .landscapeRight]
        }
    }
}

/// 默认是竖屏显示
var orientationSupport: EZPlayerOrientation = .portrait







