//
//  CatagoryList.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/6.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

struct CatagoryList: Mappable {
    
    var catalog_id : Int = defaultId
    var classContent : String = ""
    var class_layer : Int = defaultId
    var class_list : String = ""
    var code : Int = defaultId
    var ico_url : String = ""
    var id : Int = defaultId
    var img_url : String = ""
    var linkUrl : String = ""
    var parentId : Int = defaultId
    var remark : String = ""
    var seo_description : String = ""
    var seo_keywords : String = ""
    var seo_title : String = ""
    var sortId : Int = defaultId
    var title : String = ""
    var wid : Int = defaultId
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        catalog_id <- map["catalog_id"]
        classContent <- map["class_content"]
        class_layer <- map["class_layer"]
        class_list <- map["class_list"]
        code <- map["code"]
        ico_url <- map["ico_url"]
        id <- map["id"]
        img_url <- map["img_url"]
        linkUrl <- map["link_url"]
        parentId <- map["parent_id"]
        remark <- map["remark"]
        seo_description <- map["seo_description"]
        seo_keywords <- map["seo_keywords"]
        seo_title <- map["seo_title"]
        sortId <- map["sort_id"]
        title <- map["title"]
        wid <- map["wid"]
    }
    
}


