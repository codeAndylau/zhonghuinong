//
//  HotViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import JXCategoryView

class HotViewController: ViewController {
    
    var categoryView: JXCategoryTitleView!
    var listContainerView: JXCategoryListContainerView!
    
    var titles: [String] = [] // "全网产品","新鲜水果","肉禽蛋类","粮油干货","乳品烘焙"
    var controllers: [ComponentViewController] = []
    
    var catagoryList: [CatagoryList] = [] {
        didSet {
            for item in catagoryList {
                titles.append(item.title)
                
                let vc = ComponentViewController()
                controllers.append(vc)
            }
        }
    }    
    
    override func makeUI() {
        super.makeUI()
        statusBarStyle.accept(true)
        
        navigationItem.titleView = titleView
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor = UIColor.white
        
        view.backgroundColor = Color.whiteColor
        view.addSubview(topView)
        
        // 初始化JXCategoryTitleView-APP分类切换滚动视图
        categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: 42))
        categoryView.delegate = self
        categoryView.titles = titles
        categoryView.titleColor = UIColor.white
        categoryView.titleSelectedColor = UIColor.white
        categoryView.titleSelectedFont = UIFont.boldSystemFont(ofSize: 16)
        
        let lineView = JXCategoryIndicatorLineView()
        lineView.indicatorLineViewColor = UIColor.white
        lineView.lineStyle = .IQIYI
        categoryView.indicators = [lineView]
        view.addSubview(categoryView)
        
        listContainerView = JXCategoryListContainerView(delegate: self)
        listContainerView.frame = CGRect(x: 0, y: kNavBarH+44, width: kScreenW, height: kScreenH-kNavBarH-44-kBottomViewH)
        view.addSubview(listContainerView)
        
        //关联cotentScrollView，关联之后才可以互相联动！！！
        categoryView.contentScrollView = listContainerView.scrollView
    }

    override func bindViewModel() {
        super.bindViewModel()
    }
    
    
    // MARK: - Lazy
    
    lazy var titleView = UIImageView(image: UIImage(named: "farm_hot_icon"))
    
    lazy var topView = HotView.loadView()

    lazy var bottomView = HotBottomView.loadView()
    
}

extension HotViewController: JXCategoryViewDelegate {

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

extension HotViewController: JXCategoryListContainerViewDelegate {
    
    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        return self.titles.count
    }
    
    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        switch index {
//        case 0:
//            return HotAllViewController()
//        case 1:
//            return HotFruitViewController()
//        case 2:
//            return HotMeatViewController()
//        case 3:
//            return HotOilViewController()
//        case 4:
//            return HotDairyViewController()
        default:
            return ComponentViewController()
        }
    }
    
}
