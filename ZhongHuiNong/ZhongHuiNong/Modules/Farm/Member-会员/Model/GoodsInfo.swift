//
//  GoodsInfo.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/6.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

/// 商品信息
struct GoodsInfo: Mappable {
    
    var addDate : String = ""
    var brandId : Int = defaultId
    var catalogId : Int = defaultId
    var categoryId : Int = defaultId
    var costPrice : CGFloat = 0
    var descriptionField : String = ""
    var expiryEndDate : String = ""
    var focusImgUrl : String = ""
    var goodreputation_num : Int = defaultId
    var hotsale : Bool = false
    var id : Int = defaultId
    var latest : Bool = false
    var link_url : String = ""
    var marketPrice : Int = defaultId
    var ordersNum : Int = defaultId
    var productName : String = ""
    var productCode : String = ""
    var productionDate : String = ""
    var recommended : Bool = false
    var salePrice : CGFloat = 0
    var seo_description : String = ""
    var seo_keywords : String = ""
    var seo_title : String = ""
    var share_num : Int = defaultId
    var shortDesc : String = ""
    var sku : String = ""
    var sort_id : Int = defaultId
    var specialOffer : Bool = false
    var stock : Int = defaultId
    var thumbnailsUrll : String = ""
    var unit : String = ""
    var updateDate : String = ""
    var upselling : Bool = false
    var vistiCounts : Int = defaultId
    var weight : Int = defaultId
    var wid : Int = defaultId
    var youjia : Int = defaultId
    
    var checked: Bool = true   // 默认是被选中的
    var goodsNum: CGFloat = 1  // 默认只添加了一个

    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        addDate <- map["addDate"]
        brandId <- map["brandId"]
        catalogId <- map["catalogId"]
        categoryId <- map["categoryId"]
        costPrice <- map["costPrice"]
        descriptionField <- map["description"]
        expiryEndDate <- map["expiryEndDate"]
        focusImgUrl <- map["focusImgUrl"]
        goodreputation_num <- map["goodreputation_num"]
        hotsale <- map["hotsale"]
        id <- map["id"]
        latest <- map["latest"]
        link_url <- map["link_url"]
        marketPrice <- map["marketPrice"]
        ordersNum <- map["orders_num"]
        productName <- map["productName"]
        productCode <- map["product_code"]
        productionDate <- map["productionDate"]
        recommended <- map["recommended"]
        salePrice <- map["salePrice"]
        seo_description <- map["seo_description"]
        seo_keywords <- map["seo_keywords"]
        seo_title <- map["seo_title"]
        share_num <- map["share_num"]
        shortDesc <- map["shortDesc"]
        sku <- map["sku"]
        sort_id <- map["sort_id"]
        specialOffer <- map["specialOffer"]
        stock <- map["stock"]
        thumbnailsUrll <- map["thumbnailsUrll"]
        unit <- map["unit"]
        updateDate <- map["updateDate"]
        upselling <- map["upselling"]
        vistiCounts <- map["vistiCounts"]
        weight <- map["weight"]
        wid <- map["wid"]
        youjia <- map["youjia"]
    }
}
