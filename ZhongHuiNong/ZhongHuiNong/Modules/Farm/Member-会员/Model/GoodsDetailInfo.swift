//
//  GoodsDetailInfo.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/7.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

/// 商品详情信息
struct GoodsDetailInfo: Mappable {
    
    var addDate : String = ""
    var albums : [Albums] = []
    var attrs : [Attrs] = []
    var brandId : Int = defaultId
    var catalogId : Int = defaultId
    var categoryId : Int = defaultId
    var costPrice : CGFloat = 0
    var descriptionField : String = ""
    var expiryEndDate : String = ""
    var focusImgUrl : String = ""
    var goodreputationNum : Int = defaultId
    var hotsale : Bool = false
    var id : Int = defaultId
    var latest : Bool = false
    var marketPrice : Int = defaultId
    var ordersNum : Int = defaultId
    var productName : String = ""
    var productCode : String = ""
    var productionDate : String = ""
    var recommended : Bool = false
    var salePrice : CGFloat = 0
    var seoDescription : String = ""
    var seoKeywords : String = ""
    var seoTitle : String = ""
    var shareNum : Int = defaultId
    var shortDesc : String = ""
    var sku : String = ""
    var skulist : [Skulist] = []
    var sortId : Int = defaultId
    var specialOffer : Bool = false
    var speclist : [Speclist] = []
    var stock : Int = defaultId
    var thumbnailsUrll : String = ""
    var unit : String = ""
    var updateDate : String = ""
    var upselling : Bool = false
    var vistiCounts : Int = defaultId
    var weight : Int = defaultId
    var wid : Int = defaultId
    var youjia : Int = defaultId
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        addDate <- map["addDate"]
        albums <- map["albums"]
        attrs <- map["attrs"]
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
        skulist <- map["skulist"]
        sortId <- map["sort_id"]
        specialOffer <- map["specialOffer"]
        speclist <- map["speclist"]
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

/// 相册
struct Albums: Mappable {
    
    var addTime : String = ""
    var id : Int = defaultId
    var originalPath : String = ""
    var productId : Int = defaultId
    var remark : String = ""
    var thumbPath : String = ""
    var wid : Int = defaultId
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        addTime <- map["add_time"]
        id <- map["id"]
        originalPath <- map["original_path"]
        productId <- map["productId"]
        remark <- map["remark"]
        thumbPath <- map["thumb_path"]
        wid <- map["wid"]
    }
}

/// 商品属性
struct Attrs: Mappable {
    
    var id = defaultId
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
    }
}

/// speclist
struct Speclist: Mappable {
    
    var id = defaultId
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
    }
}

/// skuList
struct Skulist: Mappable {
    
    var createPerson : String = ""
    var createTime : String = ""
    var goodNo : String = ""
    var id : Int = defaultId
    var marketPrice : Int = defaultId
    var productId : Int = defaultId
    var remark : String = ""
    var sellPrice : Int = defaultId
    var specIds : String = ""
    var specText : String = ""
    var stockQuantity : Int = defaultId
    var updatePerson : String = ""
    var updateTime : String = ""
    var wid : Int = defaultId
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        createPerson <- map["create_person"]
        createTime <- map["create_time"]
        goodNo <- map["good_no"]
        id <- map["id"]
        marketPrice <- map["market_price"]
        productId <- map["product_id"]
        remark <- map["remark"]
        sellPrice <- map["sell_price"]
        specIds <- map["spec_ids"]
        specText <- map["spec_text"]
        stockQuantity <- map["stock_quantity"]
        updatePerson <- map["update_person"]
        updateTime <- map["update_time"]
        wid <- map["wid"]
    }
}
