//
//  PrivatefarmCropsModel.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import ObjectMapper

/// 私家农场
struct FarmLand: Mappable {
    
    var id = -1
    var name = ""
    var userId = -1
    var wid = -1
    var did = ""
    var cameraUrl = ""
    var status = ""
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        userId <- map["userId"]
        wid <- map["wid"]
        did <- map["did"]
        cameraUrl <- map["cameraUrl"]
        status <- map["status"]
    }
    
}

/// 传感器
struct FarmSensordata: Mappable {
    
    var water: CGFloat = -1
    var temperature: CGFloat = -1
    var cO2: CGFloat = -1
    var illumination: CGFloat = -1
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        water <- map["water"]
        temperature <- map["temperature"]
        cO2 <- map["cO2"]
        illumination <- map["illumination"]
    }
    
}

/// 请求视频播放的token
struct EZAccessToken: Codable {
    var accessToken = ""
    var expireTime = 0.0
    init() {}
    init(a: String, e: Double) {
        self.accessToken = a
        self.expireTime = e
    }
}


struct PrivatefarmCropsModel {
    var color: Int64 = 0x0BC7D8
    var title = "水份"
    var unit = "ppi"
    var start = "0%"
    var end: CGFloat = 100
    var total: CGFloat = 524
    
    init() {}
    init(color: Int64, title: String, total: CGFloat, unit: String, start: String, end: CGFloat) {
        self.color = color
        self.title = title
        self.total = total
        self.unit = unit
        self.start = start
        self.end = end
    }
}
