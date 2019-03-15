//
//  DispatchDateInfo.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/11.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

struct DispatchDateInfo: Mappable {
    
    var id : Int = defaultId
    var udpatedat : String = ""
    var userid : Int = defaultId
    
    /// 星期一
    var monday : Bool = false
    
    /// 星期二
    var tuesday : Bool = false
    
    /// 星期三
    var wednesday : Bool = false
    
    /// 星期四
    var thursday : Bool = false
    
    /// 星期五
    var friday : Bool = false
    
    /// 星期六
    var saturday : Bool = false
    
    /// 星期天
    var sunday : Bool = false
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        friday <- map["friday"]
        id <- map["id"]
        monday <- map["monday"]
        saturday <- map["saturday"]
        sunday <- map["sunday"]
        thursday <- map["thursday"]
        tuesday <- map["tuesday"]
        udpatedat <- map["udpatedat"]
        userid <- map["userid"]
        wednesday <- map["wednesday"]
    }
}
