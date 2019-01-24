//
//  HomeModel.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

struct HomePublicityEntity: Mappable {
    
    var title : String = ""
    var locationid : Int = -1
    var updateat : Int = -1
    var date : String = ""
    var abstractsection : String = ""
    var createat : Double = 0
    var createby : String = ""
    var fileUrl : String = ""
    var updateby : String = ""
    var id : Int = -1
    var texts: String = ""
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        locationid <- map["locationid"]
        updateat <- map["updateat"]
        date <- map["date"]
        abstractsection <- map["abstractsection"]
        createat <- map["createat"]
        createby <- map["createby"]
        fileUrl <- map["fileUrl"]
        updateby <- map["updateby"]
        id <- map["id"]
        texts <- map["texts"]
    }
}
