//
//  KuaidiInfo.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/11.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

struct KuaidiInfo: Mappable {
    
    var deliverystatus : String = ""
    var expName : String = ""
    var expPhone : String = ""
    var expSite : String = ""
    var issign : String = ""
    var list : [ListInfo] = []
    var number : String = ""
    var type : String = ""
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        deliverystatus <- map["deliverystatus"]
        expName <- map["expName"]
        expPhone <- map["expPhone"]
        expSite <- map["expSite"]
        issign <- map["issign"]
        list <- map["list"]
        number <- map["number"]
        type <- map["type"]
    }
    
    /*
     {
     "status": "0",
     "msg": "ok",
     "result": {
     "number": "780098068058",
     "type": "zto",
     "list": [{
     "time": "2018-03-09 11:59:26",
     "status": "【石家庄市】 快件已在 【长安三部】 签收,签收人: 本人, 感谢使用中通快递,期待再次为您服务!"
     }, {
     "time": "2018-03-09 09:03:10",
     "status": "【石家庄市】 快件已到达 【长安三部】（0311-85344265）,业务员 容晓光（13081105270） 正在第1次派件, 请保持电话畅通,并耐心等待"
     }, {
     "time": "2018-03-08 23:43:44",
     "status": "【石家庄市】 快件离开 【石家庄】 发往 【长安三部】"
     }, {
     "time": "2018-03-08 21:00:44",
     "status": "【石家庄市】 快件到达 【石家庄】"
     }, {
     "time": "2018-03-07 01:38:45",
     "status": "【广州市】 快件离开 【广州中心】 发往 【石家庄】"
     }, {
     "time": "2018-03-07 01:36:53",
     "status": "【广州市】 快件到达 【广州中心】"
     }, {
     "time": "2018-03-07 00:40:57",
     "status": "【广州市】 快件离开 【广州花都】 发往 【石家庄中转】"
     }, {
     "time": "2018-03-07 00:01:55",
     "status": "【广州市】 【广州花都】（020-37738523） 的 马溪 （18998345739） 已揽收"
     }],
     "deliverystatus": "3",         /*  1.在途中 2.正在派件 3.已签收 4.派送失败  */
     "issign": "1",                  /*  1.是否签收  */
     "expName": "中通快递",
     "expSite": "www.zto.com",
     "expPhone": "95311"
     }
     }
     */
}

struct ListInfo: Mappable {
    
    var status : String = ""
    var time : String = ""
    
    var cell_H: CGFloat {
        var h: CGFloat = 0
        h = getTextRectSize(text: status, font: UIFont.boldSystemFont(ofSize: 13), size: CGSize(width: kScreenW - 85, height: CGFloat(MAXFLOAT))).height
        return 65 + h
    }
    
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        status <- map["status"]
        time <- map["time"]
    }
}
