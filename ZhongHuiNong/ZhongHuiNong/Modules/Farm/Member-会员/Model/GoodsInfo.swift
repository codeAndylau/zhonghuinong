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
    var costPrice : Int = defaultId
    var descriptionField : String = ""
    var detailImgUrl : String = ""
    var expiryEndDate : AnyObject?
    var focusImgUrl : String = ""
    var goodreputationNum : Int = defaultId
    var hotsale : Bool = false
    var id : Int = defaultId
    var latest : Bool = false
    var linkUrl : String = ""
    var marketPrice : CGFloat = 0
    var ordersNum : Int = defaultId
    var productName : String = ""
    var productCode : String = ""
    var productionDate : AnyObject?
    var recommended : Bool = false
    var salePrice : CGFloat = 0
    var seoDescription : String = ""
    var seoKeywords : String = ""
    var seoTitle : String = ""
    var shareNum : Int = defaultId
    var shortDesc : String = ""
    var sku : String = ""
    var sortId : Int = defaultId
    var specialOffer : Bool = false
    var stock : Int = defaultId
    var thumbnailsUrll : String = ""
    var unit : String = ""
    var updateDate : String = ""
    var upselling : Bool = false
    var vistiCounts : Int = defaultId
    var weight : Int = defaultId
    var wid : Int = defaultId
    var wordImgUrl : String = ""
    var youjia : Int = defaultId
    

    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        addDate <- map["addDate"]
        brandId <- map["brandId"]
        catalogId <- map["catalogId"]
        categoryId <- map["categoryId"]
        costPrice <- map["costPrice"]
        descriptionField <- map["description"]
        detailImgUrl <- map["detailImgUrl"]
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
        wordImgUrl <- map["wordImgUrl"]
        youjia <- map["youjia"]
    }
}
