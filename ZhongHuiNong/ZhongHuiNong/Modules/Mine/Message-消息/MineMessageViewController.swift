//
//  MineMessageViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import JXSegmentedView

class MineMessageViewController: ViewController {

    
    lazy var listContainerView: JXSegmentedListContainerView = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    var titles = ["产品上新","在线客服","系统通知"]
    var isMsg = true
    
    override func makeUI() {
        super.makeUI()
        navigationItem.title = "消息提醒"
        
        if isMsg {
            
            //配置数据源
            let dataSource = JXSegmentedTitleDataSource()
            dataSource.titles = ["产品上新","在线客服","系统通知"]
//            dataSource.titleNormalColor = UIColor.hexColor(0x999999)
//            dataSource.titleNormalFont = UIFont.systemFont(ofSize: 14)
//            dataSource.titleSelectedColor = UIColor.hexColor(0x1DD1A8)
//            dataSource.titleSelectedFont = UIFont.boldSystemFont(ofSize: 16)
            dataSource.reloadData(selectedIndex: 0) //reloadData(selectedIndex:)一定要调用
            
            let segmentedView = JXSegmentedView()
            segmentedView.dataSource = dataSource

            //配置指示器
            let indicator = JXSegmentedIndicatorLineView()
            indicator.indicatorWidth = 20
            segmentedView.indicators = [indicator]
            
            
            segmentedView.frame = CGRect(x: 0, y: kNavBarH, width: kScreenW, height: 42)
            segmentedView.delegate = self
            view.addSubview(segmentedView)
            
            segmentedView.contentScrollView = listContainerView.scrollView

            listContainerView.frame = CGRect(x: 0, y: kNavBarH+44, width: kScreenW, height: kScreenH-kNavBarH-44)
            listContainerView.didAppearPercent = 0.01
            view.addSubview(listContainerView)

        }else {
            view.addSubview(empty)
        }

    }

    override func bindViewModel() {
        super.bindViewModel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    // MARK: - Lazy
    
    lazy var empty = MineMessageEmptyView.loadView()

}

extension MineMessageViewController: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
//        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
//            //先更新数据源的数据
//            dotDataSource.dotStates[index] = false
//            //再调用reloadItem(at: index)
//            segmentedView.reloadItem(at: index)
//        }
//        
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
        listContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        //传递scrollingFrom事件给listContainerView，必须调用！！！
        listContainerView.segmentedViewScrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex: segmentedView.selectedIndex)
    }
   
    
}

extension MineMessageViewController: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
         return titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        switch index {
        case 0:
            return MineMsgComponentViewController()
        case 1:
            return MineMsgComponentViewController()
        case 2:
            return MineMsgComponentViewController()
        default:
            return MineMsgComponentViewController()
        }
    }
    
    
}

