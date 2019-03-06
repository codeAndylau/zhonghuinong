//
//  BannerList.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/6.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

/// 首页轮播图
struct BannerList: Mappable {
    
    var id = -1
    var wid = -1
    var bannerName = ""
    var bannerPicUrl = ""
    var bannerLinkUrl = ""
    var remark = ""
    var sort_id = -1
    var createDate = ""
    var minapp_link = ""
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        wid <- map["wid"]
        bannerName <- map["bannerName"]
        bannerPicUrl <- map["bannerPicUrl"]
        bannerLinkUrl <- map["bannerLinkUrl"]
        remark <- map["remark"]
        sort_id <- map["sort_id"]
        createDate <- map["createDate"]
        minapp_link <- map["minapp_link"]
    }
    
}
