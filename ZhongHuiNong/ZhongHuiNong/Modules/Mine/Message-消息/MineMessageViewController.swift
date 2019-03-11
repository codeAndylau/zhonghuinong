//
//  MineMessageViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import JXCategoryView

class MineMessageViewController: ViewController {

    var categoryView: JXCategoryTitleView!
    var listContainerView: JXCategoryListContainerView!
    
    var titles = ["产品上新","在线客服","系统通知"]
    var isMsg = false
    
    override func makeUI() {
        super.makeUI()
        navigationItem.title = "消息提醒"
        
        if isMsg {
            
            // 初始化JXCategoryTitleView-APP分类切换滚动视图
            categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: 42))
            categoryView.delegate = self
            categoryView.titles = titles
            categoryView.titleColor = UIColor.hexColor(0x999999)
            categoryView.titleSelectedColor = UIColor.hexColor(0x1DD1A8)
            categoryView.titleSelectedFont = UIFont.boldSystemFont(ofSize: 16)
            categoryView.titleColorGradientEnabled = false
            
            let lineView = JXCategoryIndicatorLineView()
            lineView.indicatorLineViewColor = UIColor.hexColor(0x1DD1A8)
            lineView.indicatorLineWidth = 15
            lineView.lineStyle = .IQIYI
            categoryView.indicators = [lineView]
            view.addSubview(categoryView)
            
            listContainerView = JXCategoryListContainerView(delegate: self)
            listContainerView.frame = CGRect(x: 0, y: kNavBarH+44, width: kScreenW, height: kScreenH-kNavBarH-44)
            view.addSubview(listContainerView)
            
            //关联cotentScrollView，关联之后才可以互相联动！！！
            categoryView.contentScrollView = listContainerView.scrollView

        }else {
            view.addSubview(empty)
        }

    }

    override func bindViewModel() {
        super.bindViewModel()
    }

    
    // MARK: - Lazy
    lazy var empty = MineMessageEmptyView.loadView()

}

extension MineMessageViewController: JXCategoryViewDelegate {
    
    // 点击选中的情况才会调用该方法
    func categoryView(_ categoryView: JXCategoryBaseView!, didClickSelectedItemAt index: Int) {
        debugPrints("点击了第\(index)个")
        listContainerView.didClickSelectedItem(at: index)
    }
    
    // 正在滚动中的回调
    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        listContainerView.scrolling(fromLeftIndex: leftIndex, toRightIndex: rightIndex, ratio: ratio, selectedIndex: categoryView.selectedIndex)
    }
    
}

extension MineMessageViewController: JXCategoryListContainerViewDelegate {
    
    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        return self.titles.count
    }
    
    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        switch index {
        case 0: return MineNewProductViewController()
        case 1: return MineCustomerViewController()
        case 2: return MineSystemViewController()
        default:
            return MineMsgComponentViewController()
        }
    }
    
}

