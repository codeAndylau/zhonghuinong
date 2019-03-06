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
    
    var catalogId : Int?
    var classContent : String?
    var classLayer : Int?
    var classList : String?
    var code : AnyObject?
    var icoUrl : String?
    var id : Int?
    var imgUrl : String?
    var linkUrl : String?
    var parentId : Int?
    var remark : String?
    var seoDescription : String?
    var seoKeywords : String?
    var seoTitle : String?
    var sortId : Int?
    var title : String?
    var wid : Int?
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        catalogId <- map["catalog_id"]
        classContent <- map["class_content"]
        classLayer <- map["class_layer"]
        classList <- map["class_list"]
        code <- map["code"]
        icoUrl <- map["ico_url"]
        id <- map["id"]
        imgUrl <- map["img_url"]
        linkUrl <- map["link_url"]
        parentId <- map["parent_id"]
        remark <- map["remark"]
        seoDescription <- map["seo_description"]
        seoKeywords <- map["seo_keywords"]
        seoTitle <- map["seo_title"]
        sortId <- map["sort_id"]
        title <- map["title"]
        wid <- map["wid"]
    }
    
}


