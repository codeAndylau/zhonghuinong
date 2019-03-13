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
    
    /// 商品列表信息
    var goodsInfo: [GoodsInfo] = [] 
    
    init(page: Int = 1, goodsId: Int = 1) {
        self.page = page
        self.goodsId = goodsId
    }
}
