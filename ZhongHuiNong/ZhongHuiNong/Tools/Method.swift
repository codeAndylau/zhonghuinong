//
//  Method.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation

/// 本地化字符串
///
/// - Parameters:
///   - text: 显示文本
///   - comment: 默认值
/// - Returns: 返回字符串
public func localized(_ text: String, comment: String = "") -> String {
    return NSLocalizedString(text, comment: comment)
}
