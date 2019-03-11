//
//  DispatchMenuInfo.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/11.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

struct DispatchMenuInfo: Mappable {
    
    var focusImgUrl : String = ""
    var id : Int = defaultId
    var producename : String = ""
    var productid : Int = defaultId
    var unitweight : CGFloat = 0
    
    var num = 0 // 默认没有选择商品
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        focusImgUrl <- map["focusImgUrl"]
        id <- map["id"]
        producename <- map["producename"]
        productid <- map["productid"]
        unitweight <- map["unitweight"]
    }
}
