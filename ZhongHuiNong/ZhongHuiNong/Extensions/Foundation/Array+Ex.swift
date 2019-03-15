//
//  Array+Ex.swift
//  ZhongHuiNong
//
//  Created by lau Andy on 2019/3/13.
//  Copyright © 2019年 Andylau. All rights reserved.
//

import Foundation

extension Array {
    // 数组去重
    func id_filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}
