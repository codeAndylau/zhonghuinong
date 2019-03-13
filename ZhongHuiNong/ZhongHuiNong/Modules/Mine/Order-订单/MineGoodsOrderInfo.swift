//
//  MineGoodsOrderInfo.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/10.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

/// 用户的个人订单信息
struct MineGoodsOrderInfo: Mappable {
    
    var add_time : String = ""
    var amountReal : Double = 0
    var express_id : Int = defaultId
    var express_no : String = ""
    var express_status : Int = defaultId
    var id : Int = defaultId
    var logisticsList : [String] = []
    var message : String = ""
    var orderGoodsList : [OrderGoodsList] = []
    var orderNumber : String = ""
    var payment_id : Int = defaultId
    var payment_status : Int = defaultId
    var payment_time : String = ""
    var status : Int = defaultId
    var statusStr : String = ""
    var tot_goods_num : Int = defaultId
 
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        add_time <- map["add_time"]
        amountReal <- map["amountReal"]
        express_id <- map["express_id"]
        express_no <- map["express_no"]
        express_status <- map["express_status"]
        id <- map["id"]
        logisticsList <- map["logisticsList"]
        message <- map["message"]
        orderGoodsList <- map["orderGoodsList"]
        orderNumber <- map["orderNumber"]
        payment_id <- map["payment_id"]
        payment_status <- map["payment_status"]
        payment_time <- map["payment_time"]
        status <- map["status"]
        statusStr <- map["statusStr"]
        tot_goods_num <- map["tot_goods_num"]
    }
    
}

struct OrderGoodsList: Mappable {
    
    var goodsId : Int = defaultId
    var goodsPic : String = ""
    var goodsPrice : CGFloat = 0
    var goodsTitle : String = ""
    var id : Int = defaultId
    var orderId : Int = defaultId
    var point : Int = defaultId
    var quantity : Int = defaultId
    var realPrice : Int = defaultId
    var reviewsStatus : Int = defaultId
    var specIds : String = ""
    var specText : String = ""
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        goodsId <- map["goods_id"]
        goodsPic <- map["goods_pic"]
        goodsPrice <- map["goods_price"]
        goodsTitle <- map["goods_title"]
        id <- map["id"]
        orderId <- map["order_id"]
        point <- map["point"]
        quantity <- map["quantity"]
        realPrice <- map["real_price"]
        reviewsStatus <- map["reviews_status"]
        specIds <- map["spec_ids"]
        specText <- map["spec_text"]
    }
}
