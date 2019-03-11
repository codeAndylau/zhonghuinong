//
//  DispatchVegetablesInfo.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/11.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

/// 用户所选配送的蔬菜信息
struct DispatchVegetablesInfo: Mappable {
    
    var address : String = ""
    var assigneeid : AnyObject?
    var completedat : AnyObject?
    var contactperson : String?
    var createdat : String = ""
    var deliverynum : Int = defaultId
    var id : Int = defaultId
    var phonenumber : String = ""
    var scheduleday : String = ""
    var sfDispatchOrderDetail : [AnyObject]?
    var status : Int = defaultId
    var userid : Int = defaultId
    var weight : Float = 0
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        address <- map["address"]
        assigneeid <- map["assigneeid"]
        completedat <- map["completedat"]
        contactperson <- map["contactperson"]
        createdat <- map["createdat"]
        deliverynum <- map["deliverynum"]
        id <- map["id"]
        phonenumber <- map["phonenumber"]
        scheduleday <- map["scheduleday"]
        sfDispatchOrderDetail <- map["sfDispatchOrderDetail"]
        status <- map["status"]
        userid <- map["userid"]
        weight <- map["weight"]
    }
}
