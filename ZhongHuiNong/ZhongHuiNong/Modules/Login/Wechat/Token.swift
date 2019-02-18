//
//  Token.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

/// 用户token
struct Token: Mappable, Codable {
    
    var token: String = ""
    var valid: Bool = false
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        token <- map["token"]
        valid <- map["valid"]
    }

}
