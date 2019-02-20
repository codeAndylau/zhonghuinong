//
//  FarmViewModel.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/24.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation

enum Shape: CaseIterable {
    case rectangle
    case circle(Double)
    case trangle
    
    func dd() {
        print("所有形状类型 --- \(Shape.allCases)")
        
        /// 生成随机数
       let _ = Int.random(in: 0...111)
       let _ = Bool.random()
       let _ = Double.random(in: 0...111)
    }

    static func random() -> Shape {
        return self.allCases.randomElement()!
    }
    
    /// 扔硬币正反面的几率
    func coin(count: Int) {
        var result = (head: 0, back: 0)
        
        for _ in 1...count {
            if Bool.random() {
                result.head += 1
            }else {
                result.back += 1
            }
        }
        print("Head:\(result.head)  Back: \(result.back)")
    }
    
    func bijiao() {
        
        let username = "hhh"
        let password = "xxx"
        
        if case ("hhh", "xxx") = (username, password) {
            print("用户名和密码满足条件")
        }
    }
}

extension Shape {
    public typealias AllCases = [Shape]
    public static var allCases : AllCases {
        return [Shape.rectangle, Shape.circle(1.0), Shape.trangle]
    }
}


