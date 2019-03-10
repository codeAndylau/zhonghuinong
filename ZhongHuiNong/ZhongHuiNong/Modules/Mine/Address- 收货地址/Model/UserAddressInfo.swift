//
//  UserAddressInfo.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/7.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

/// 用户地址信息
struct UserAddressInfo: Mappable {
    
    var address : String = ""
    var cityId : String = ""
    var citystr : String = ""
    var code : String = ""
    var districtId : String = ""
    var districtstr : String = ""
    var fromplat : String = ""
    var id : Int = defaultId
    var isDefault : Bool = false
    var latitude : String = ""
    var linkMan : String = ""
    var longitude : String = ""
    var mobile : String = ""
    var provinceId : String = ""
    var provincestr : String = ""
    var regionstr : String = ""
    var userid : Int = defaultId
    var wid : Int = defaultId
    var preaddress: String = ""
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        address <- map["address"]
        cityId <- map["cityId"]
        citystr <- map["citystr"]
        code <- map["code"]
        districtId <- map["districtId"]
        districtstr <- map["districtstr"]
        fromplat <- map["fromplat"]
        id <- map["id"]
        isDefault <- map["isDefault"]
        latitude <- map["latitude"]
        linkMan <- map["linkMan"]
        longitude <- map["longitude"]
        mobile <- map["mobile"]
        provinceId <- map["provinceId"]
        provincestr <- map["provincestr"]
        regionstr <- map["regionstr"]
        userid <- map["userid"]
        wid <- map["wid"]
        preaddress <- map["preaddress"]
    }
}


