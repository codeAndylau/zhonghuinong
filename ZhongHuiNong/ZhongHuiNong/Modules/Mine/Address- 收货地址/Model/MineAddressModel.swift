//
//  MineAddressModel.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

struct Province: Mappable {
    
    var state = ""
    var cities: [City] = []
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        state <- map["state"]
        cities <- map["cities"]
    }
    
}

struct City: Mappable {
    
    var city = ""
    var areas: [District] = []
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        city <- map["city"]
        areas <- map["areas"]
    }
}

struct District: Mappable {
    
    var county = ""
    var streets: [String] = []
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        county <- map["county"]
        streets <- map["streets"]
    }
}

struct Town: Mappable {
    
    var street = ""
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        street <- map["street"]
    }
}
