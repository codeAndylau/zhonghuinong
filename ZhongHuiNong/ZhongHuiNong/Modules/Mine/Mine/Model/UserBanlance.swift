//
//  UserBanlance.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/8.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

struct UserBanlance: Mappable {
    
    var id = defaultId
    var userid = defaultId
    var creditbalance = 0.0
    var weightbalance = 0.0
    var deliverybalance = 0
    var createdat = ""
    var updatedat = ""
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        userid <- map["userid"]
        creditbalance <- map["creditbalance"]
        weightbalance <- map["weightbalance"]
        deliverybalance <- map["deliverybalance"]
        createdat <- map["createdat"]
        updatedat <- map["updatedat"]
    }
}
