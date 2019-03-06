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
    
    var addDate : String?
    var brandId : Int?
    var catalogId : Int?
    var categoryId : Int?
    var costPrice : Int?
    var descriptionField : String?
    var expiryEndDate : AnyObject?
    var focusImgUrl : String?
    var goodreputationNum : Int?
    var hotsale : Bool?
    var id : Int?
    var latest : Bool?
    var linkUrl : String?
    var marketPrice : Int?
    var ordersNum : Int?
    var productName : String?
    var productCode : String?
    var productionDate : AnyObject?
    var recommended : Bool?
    var salePrice : Int?
    var seoDescription : String?
    var seoKeywords : String?
    var seoTitle : String?
    var shareNum : Int?
    var shortDesc : String?
    var sku : String?
    var sortId : Int?
    var specialOffer : Bool?
    var stock : Int?
    var thumbnailsUrll : String?
    var unit : String?
    var updateDate : String?
    var upselling : Bool?
    var vistiCounts : Int?
    var weight : Int?
    var wid : Int?
    var youjia : Int?

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
        goodreputationNum <- map["goodreputation_num"]
        hotsale <- map["hotsale"]
        id <- map["id"]
        latest <- map["latest"]
        linkUrl <- map["link_url"]
        marketPrice <- map["marketPrice"]
        ordersNum <- map["orders_num"]
        productName <- map["productName"]
        productCode <- map["product_code"]
        productionDate <- map["productionDate"]
        recommended <- map["recommended"]
        salePrice <- map["salePrice"]
        seoDescription <- map["seo_description"]
        seoKeywords <- map["seo_keywords"]
        seoTitle <- map["seo_title"]
        shareNum <- map["share_num"]
        shortDesc <- map["shortDesc"]
        sku <- map["sku"]
        sortId <- map["sort_id"]
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
