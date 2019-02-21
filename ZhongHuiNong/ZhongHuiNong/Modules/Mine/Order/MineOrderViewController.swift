//
//  MineOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineOrderViewController: ViewController {

    override func makeUI() {
        super.makeUI()
        navigationItem.title = "我的订单"
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    
    override func updateUI() {
        super.updateUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lazy
    lazy var pageTitleView: PageTitleView = {
        let frame = CGRect(x: 0, y: kNavBarH, width: kScreenW, height: 44)
        let titles = ["全部","待付款","待配送","待收货"]
        let view = PageTitleView(frame: frame, titles: titles, currentIndex: 1)
        view.delegate = self
        return view
    }()
    
    lazy var pageContentView: PageContentView = {
        let frame = CGRect(x: 0, y: kNavBarH+44, width: kScreenW, height: kScreenH-kNavBarH-44)
        let childVCs = [MineAllOrderViewController(),MinePayOrderViewController(),
                        MineSendOrderViewController(),MineAcceptOrderViewController()]
        
        let view = PageContentView(frame: frame, childVcs: childVCs, parentViewController: self, offsetX: kScreenW)
        view.backgroundColor = Color.backdropColor
        view.delegate = self
        return view
    }()
    
}

extension MineOrderViewController: PageTitleViewDelegate, PageContentViewDelegate {
    
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
    
    func pageContentView(_ contentView: PageContentView, targetIndex index: Int) {
        pageTitleView.setTitleWithTargetIndex(index)
    }
    
    
}
