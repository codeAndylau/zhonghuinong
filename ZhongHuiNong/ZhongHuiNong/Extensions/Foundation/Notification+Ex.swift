//
//  Notification+Ex.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/28.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    
    /// 更新用户嘻嘻
    static let updateUserInfo = NSNotification.Name(localized("updateUserInfo"))
    /// 首页商品分类点击
    static let HomeGoodsClassDid = NSNotification.Name(localized("HomeGoodsClassDid"))
    /// 微信登录通知
    static let wechatLoginNotification = NSNotification.Name(localized("wechatLoginNotification"))
    /// 用户地址更新通知
    static let userAddressDidChange = NSNotification.Name(localized("userAddressDidChange"))
    /// 用户确定订单地址编辑
    static let userOrderAddressEdit = NSNotification.Name(localized("userOrderAddressEdit"))
    /// 商品详情点击购物车
    static let goodsDetailCartClicked = NSNotification.Name(localized("goodsDetailCartClicked"))
    /// 购物车订单支付成功
    static let cartOrderPaySuccess = NSNotification.Name(localized("cartOrderPaySuccess"))
    
}
