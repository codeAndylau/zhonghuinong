//
//  CartOrderInfo.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/10.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

struct CartOrderInfo: Mappable {
    
    var add_time : String = ""
    var address : String = ""
    var amountReal : Int = defaultId
    var orderNumber : String = ""
    var order_id : Int = defaultId
    var phonenumber : String = ""
    var status : Int = defaultId
    var success : Bool = false
    var user_id : Int = defaultId
    var wid : Int = defaultId
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        
        add_time <- map["add_time"]
        address <- map["address"]
        amountReal <- map["amountReal"]
        orderNumber <- map["orderNumber"]
        order_id <- map["order_id"]
        phonenumber <- map["phonenumber"]
        status <- map["status"]
        success <- map["success"]
        user_id <- map["user_id"]
        wid <- map["wid"]
        
    }
}
