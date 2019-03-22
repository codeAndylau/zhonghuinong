//
//  EmptyStore.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import EmptyPage

/// 空白页管理仓库
class EmptyStore {
    
    /// 订单的空白页
    class func orderEmpty(block: @escaping (()->())) -> EmptyPageView  {
        let view = EmptyPageForOrder.initFromNib
        view.block = block
        return view.mix()
    }
    
    /// 购物车的空白页
    class func cartEmpty(block: @escaping (()->())) -> EmptyPageView  {
        let view = EmptyPageForOrder.initFromNib
        view.titleLab.text = "购物车空空如也"
        view.sureBtn.setTitle("去逛逛", for: .normal)
        view.block = block
        return view.mix()
    }
    
    /// 商品分类的空白页
    class func goodsInfoEmpty(onView: UIView) {
        let emptyView = EmptyView()
        emptyView.frame = CGRect(x: 88, y: kNavBarH, width: kScreenW-88, height: kScreenH-kNavBarH-kTabBarH)
        emptyView.tag = 1000
        emptyView.config = EmptyViewConfig(title: "该类商品暂时缺货了哟", image: UIImage(named: "basket_empty"), btnTitle: "")
        emptyView.sureBtn.isHidden = true
        removeEmpty(onView: onView)
        onView.addSubview(emptyView)
    }
    
    
    /// 网络错误的时候
    class func loadEmpty(onView: UIView, block: @escaping (()->()))  {
        let view = EmptyPageForOrder.initFromNib
        view.tag = 1000
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-kNavBarH-kTabBarH)
        view.titleLab.text = "网络请求错误"
        view.sureBtn.setTitle("重试", for: .normal)
        view.block = block
        removeEmpty(onView: onView)
        onView.addSubview(view)
    }
    
    /// 判断是否已经加载过
    class func removeEmpty(onView: UIView) {
        if let sub = onView.viewWithTag(1000) {
            onView.subviews.forEach { (item) in
                if item.tag == sub.tag {
                    item.removeFromSuperview()
                }
            }
        }
    }
    
}
