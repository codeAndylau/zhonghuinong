//
//  DispatchOrderInfo.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/11.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

struct DispatchOrderInfo: Mappable {
    
    var hasNext : Bool = false
    var hasPrev : Bool = false
    var pIndex : Int = defaultId
    var pSize : Int = defaultId
    var recordCount : Int = defaultId
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        hasNext <- map["has_next"]
        hasPrev <- map["has_prev"]
        pIndex <- map["p_index"]
        pSize <- map["p_size"]
        recordCount <- map["record_count"]
    }
}
