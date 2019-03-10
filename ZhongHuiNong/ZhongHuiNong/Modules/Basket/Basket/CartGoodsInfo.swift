//
//  CartGoodsInfo.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/10.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

/// 用户购物车信息
struct CartGoodsInfo: Mappable {

    var productid: Int = defaultId
    var quantity: Int = defaultId
    var productname: String = ""
    var marketprice: CGFloat = 0
    var sellprice: CGFloat = 0
    var focusImgUrl: String = ""
    
    var checked: Bool = true   // 默认是被选中的
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        productid <- map["productid"]
        quantity <- map["quantity"]
        productname <- map["productname"]
        marketprice <- map["marketprice"]
        sellprice <- map["sellprice"]
        focusImgUrl <- map["focusImgUrl"]
    }
}
