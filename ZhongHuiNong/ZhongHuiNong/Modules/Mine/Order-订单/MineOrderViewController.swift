//
//  MineOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import JXCategoryView

class MineOrderViewController: ViewController {

    var defaultIndex = 0
    
    var categoryView: JXCategoryTitleView!
    var listContainerView: JXCategoryListContainerView!
    
    var titles: [String] = ["全部","待付款","待配送","待收货"]
    
    override func makeUI() {
        super.makeUI()
       
        navigationItem.title = "我的订单"
        
        // 初始化JXCategoryTitleView-APP分类切换滚动视图
        categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: 42))
        categoryView.delegate = self
        categoryView.titles = titles
        categoryView.titleColor = UIColor.hexColor(0x999999)
        categoryView.titleSelectedColor = UIColor.hexColor(0x1DD1A8)
        categoryView.titleSelectedFont = UIFont.boldSystemFont(ofSize: 16)
        
        let lineView = JXCategoryIndicatorLineView()
        lineView.indicatorLineViewColor = UIColor.hexColor(0x1DD1A8)
        lineView.lineStyle = .IQIYI
        categoryView.indicators = [lineView]
        view.addSubview(categoryView)
        
        listContainerView = JXCategoryListContainerView(delegate: self)
        listContainerView.frame = CGRect(x: 0, y: kNavBarH+44, width: kScreenW, height: kScreenH-kNavBarH-44-kBottomViewH)
        view.addSubview(listContainerView)
        
        //关联cotentScrollView，关联之后才可以互相联动！！！
        categoryView.contentScrollView = listContainerView.scrollView
        
        categoryView.defaultSelectedIndex = defaultIndex
        listContainerView.defaultSelectedIndex = defaultIndex
        
    }

    override func bindViewModel() {
        super.bindViewModel()
        //view.addSubview(pageTitleView)
        //view.addSubview(pageContentView)
    }
    
    // MARK: - Lazy
    lazy var pageTitleView: PageTitleView = {
        let frame = CGRect(x: 0, y: kNavBarH, width: kScreenW, height: 44)
        let titles = ["全部","待付款","待配送","待收货"]
        let view = PageTitleView(frame: frame, titles: titles, currentIndex: 0)
        view.delegate = self
        return view
    }()
    
    lazy var pageContentView: PageContentView = {
        let frame = CGRect(x: 0, y: kNavBarH+44, width: kScreenW, height: kScreenH-kNavBarH-44)
        let childVCs = [MineAllOrderViewController(),MinePayOrderViewController(),
                        MineSendOrderViewController(),MineAcceptOrderViewController()]
        
        let view = PageContentView(frame: frame, childVcs: childVCs, parentViewController: self, offsetX: 0)
        view.backgroundColor = Color.backdropColor
        view.delegate = self
        return view
    }()
    
}

extension MineOrderViewController: JXCategoryViewDelegate {
    
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

extension MineOrderViewController: JXCategoryListContainerViewDelegate {
    
    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        return self.titles.count
    }
    
    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        switch index {
        case 0:
            return MineAllOrderViewController()
        case 1:
            return MinePayOrderViewController()
        case 2:
            return MineSendOrderViewController()
        case 3:
            return MineAcceptOrderViewController()
        default:
            return MineAllOrderViewController()
        }
    }
    
}

extension MineOrderViewController: PageTitleViewDelegate, PageContentViewDelegate {
    
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
    
    func pageContentView(_ contentView: PageContentView, targetIndex index: Int) {
        pageTitleView.setTitleWithTargetIndex(index)
    }
    
    
}
