//
//  Refresh.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/4.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import MJRefresh
import RxSwift
import RxCocoa

/// 对MJRefreshComponent增加rx扩展
extension Reactive where Base: MJRefreshComponent {
    
    var refreshing: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create { [weak control = self.base] observer  in
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    
    var endRefreshing: Binder<Bool> {
        return Binder(base) { refresh, isEnd in
            if isEnd {
                refresh.endRefreshing()
            }
        }
    }
}

enum RefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
    case resetNoMoreData
    
    static func update(_ status: RefreshStatus, tb: UIScrollView) {
        switch status {
        case .beingHeaderRefresh:
            tb.mj_header.beginRefreshing()
        case .endHeaderRefresh:
            tb.mj_header.endRefreshing()
        case .beingFooterRefresh:
            tb.mj_footer.beginRefreshing()
        case .endFooterRefresh:
            tb.mj_footer.endRefreshing()
        case .noMoreData:
            tb.mj_footer.endRefreshingWithNoMoreData()
        case .resetNoMoreData:
            tb.mj_footer.resetNoMoreData()
        default:
            break
        }
    }
}

extension UIScrollView {
    var uHead: MJRefreshHeader {
        get { return mj_header }
        set { mj_header = newValue }
    }
    
    var uFoot: MJRefreshFooter {
        get { return mj_footer }
        set { mj_footer = newValue }
    }
}

// MARK: - Header

/// 默认的下啦刷新控件
class RefreshNormalHeader: MJRefreshNormalHeader {
    override func prepare() {
        super.prepare()
        lastUpdatedTimeLabel.isHidden = true
        stateLabel.isHidden = true
    }
}

/// 带动图的下啦刷新控件
class RefreshGifHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        //        setImages([UIImage(named: "refresh_normal")!], for: .idle)
        //        setImages([UIImage(named: "refresh_will_refresh")!], for: .pulling)
        //        setImages([UIImage(named: "refresh_loading_1")!,
        //                   UIImage(named: "refresh_loading_2")!,
        //                   UIImage(named: "refresh_loading_3")!], for: .refreshing)
        //
        //        lastUpdatedTimeLabel.isHidden = true
        //        stateLabel.isHidden = true
    }
}

class MJDIYHeader: MJRefreshHeader {
    
    var label:UILabel!
    var loading:UIActivityIndicatorView!
    
    override func prepare() {
        
        super.prepare()
        
        // 设置控件的高度
        self.mj_h = 50
        
        // 添加label
        self.label =  UILabel()
        self.label.textColor = Color.themeColor
        self.label.font = UIFont.systemFont(ofSize: 12)
        self.label.textAlignment = .center
        self.addSubview(self.label)
        
        // loading
        self.loading =  UIActivityIndicatorView(style: .gray)
        self.addSubview(self.loading)
        
    }
    //在这里设置子控件的位置和尺寸
    override func placeSubviews() {
        super.placeSubviews()
        self.label.frame = self.bounds
        self.loading.center = CGPoint(x:self.mj_w/2, y:self.mj_h/2)
    }
    
    //监听控件的刷新状态
    override var state: MJRefreshState {
        didSet
        {
            switch (state) {
            case .idle:
                self.loading.stopAnimating()
                self.label.text = "峻铭健康有机食品" //我是来打酱油滴吖
            case .pulling:
                self.loading.stopAnimating()
                self.label.text = "峻铭健康有机食品"
            case .refreshing:
                self.loading.startAnimating()
                self.label.text = ""
            default: break
            }
        }
    }
    
    //监听拖拽比例（控件被拖出来的比例）
    override var pullingPercent: CGFloat {
        didSet
        {
            //debugPrint("下啦的比例---\(pullingPercent)")
        }
    }
    
    //监听scrollView的contentOffset改变
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    //监听scrollView的contentSize改变
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    //监听scrollView的拖拽状态改变
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }
}


// MARK: - Footer

/// 默认的上啦刷新控件
class RefreshBackNormalFooter: MJRefreshBackNormalFooter {}

/// 带有动图的上啦刷新控件
class RefreshBackGifFooter: MJRefreshBackGifFooter {
    
    override func prepare() {
        super.prepare()
        
        //        let idleImg = [UIImage(named: "function_zhongzhi_jiashi_1")!]
        //        let pullingImg = [UIImage(named: "function_zhongzhi_jiashi_1")!]
        //        var refreshing = [UIImage]()
        //
        //        for i in 1..<7 {
        //            let img = UIImage(named: "function_zhongzhi_jiashi_\(i)")!
        //            refreshing.append(img)
        //        }
        //
        //        setImages(idleImg, for: .idle)
        //        setImages(pullingImg, for: .pulling)
        //        setImages(refreshing, duration: 1.0, for: .refreshing)
        stateLabel.isHidden = true
        isAutomaticallyChangeAlpha = true // 根据拖拽比例自动切换透明度
    }
}


// 继承MJRefreshBackFooter
// 这个实现的是自动回弹上拉加载组件，也就是说上拉组件不会占用 tableView 单元格空间。
class MJDIYAutoFooter: MJRefreshBackFooter {
    
    var label:UILabel!
    var loading:UIActivityIndicatorView!
    
    override func prepare() {
        
        super.prepare()
        
        // 设置控件的高度
        self.mj_h = 50
        
        // 添加label
        self.label =  UILabel()
        self.label.textColor = Color.themeColor
        self.label.font = UIFont.systemFont(ofSize: 12)
        self.label.textAlignment = .center
        self.addSubview(self.label)
        
        // loading
        self.loading =  UIActivityIndicatorView(style: .gray)
        self.addSubview(self.loading)
        
    }
    //在这里设置子控件的位置和尺寸
    override func placeSubviews() {
        super.placeSubviews()
        self.label.frame = self.bounds
        self.loading.center = CGPoint(x:self.mj_w/2, y:self.mj_h/2)
    }
    
    //监听控件的刷新状态
    override var state: MJRefreshState {
        didSet
        {
            switch (state) {
            case .idle:
                self.loading.stopAnimating()
                self.label.text = "我是来打酱油滴吖"
            case .pulling:
                self.loading.stopAnimating()
                self.label.text = "我是来打酱油滴吖"
            case .refreshing:
                self.loading.startAnimating()
                self.label.text = ""
            default: break
            }
        }
    }
    
    //监听拖拽比例（控件被拖出来的比例）
    override var pullingPercent: CGFloat {
        didSet
        {
            //debugPrint("下啦的比例---\(pullingPercent)")
        }
    }
    
    //监听scrollView的contentOffset改变
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    //监听scrollView的contentSize改变
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    //监听scrollView的拖拽状态改变
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }
}
