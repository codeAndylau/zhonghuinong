//
//  StoreModel.swift
//  ZhongHuiNong
//
//  Created by lau Andy on 2019/3/13.
//  Copyright © 2019年 Andylau. All rights reserved.
//

import Foundation

struct StoreModel  {

    var page = 1
    var goodsId = 1
    var index = 0   // 对应点击的是那个cell
    var end = true  // 默认是有数据的
    
    /// 商品列表信息
    var goodsInfo: [GoodsInfo] = [] 
    
    init(page: Int = 1, goodsId: Int = 1, index: Int = 1, end: Bool = true) {
        self.page = page
        self.goodsId = goodsId
        self.index = index
        self.end = end
    }
}
