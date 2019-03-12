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
    var assigneeid : String = ""
    var completedat : String = ""
    var contactPerson : String = ""
    var createdat : String = ""
    var deliverynum : Int = defaultId
    var scheduleDay: String = ""
    var dispatchOrderDetail : [DispatchOrderDetailInfo] = []
    var phonenumber : String = ""
    var status : Int = defaultId
    var userid : Int = defaultId
    var weight : CGFloat = 0
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        address <- map["address"]
        assigneeid <- map["assigneeid"]
        completedat <- map["completedat"]
        contactPerson <- map["contactPerson"]
        createdat <- map["createdat"]
        deliverynum <- map["deliverynum"]
        scheduleDay <- map["scheduleDay"]
        dispatchOrderDetail <- map["dispatchOrderDetail"]
        phonenumber <- map["phonenumber"]
        status <- map["status"]
        userid <- map["userid"]
        weight <- map["weight"]
    }
}

struct DispatchOrderDetailInfo: Mappable {
    
    var focusImgUrl : String = ""
    var orderid : Int = defaultId
    var productid : Int = defaultId
    var productname : String = ""
    var quantity : Int = defaultId
    var weight : Int = 0
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        focusImgUrl <- map["focusImgUrl"]
        orderid <- map["orderid"]
        productid <- map["productid"]
        productname <- map["productname"]
        quantity <- map["quantity"]
        weight <- map["weight"]
    }
}
