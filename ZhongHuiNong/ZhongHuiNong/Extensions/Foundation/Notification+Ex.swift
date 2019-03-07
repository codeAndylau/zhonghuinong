//
//  Notification+Ex.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/28.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    /// 首页商品分类点击
    static let HomeGoodsClassDid = NSNotification.Name(localized("HomeGoodsClassDid"))
    /// 微信登录通知
    static let wechatLoginNotification = NSNotification.Name(localized("wechatLoginNotification"))
    /// 用户地址更新通知
    static let userAddressDidChange = NSNotification.Name(localized("userAddressDidChange"))
    
}
