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

/// 正常下拉加载
class RefreshHeader: MJRefreshNormalHeader {
    
    override func prepare() {
        super.prepare()
        lastUpdatedTimeLabel.isHidden = true
        stateLabel.isHidden = true
    }
    
}

/// Gif下拉加载
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

/// Gif上拉加载
class RefreshGifFooter: MJRefreshBackGifFooter {
    
    override func prepare() {
        super.prepare()
    }
}

/// 上拉自动加载 - 自动刷新的
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

class RefreshAutoHeader: MJRefreshHeader {}

class RefreshFooter: MJRefreshBackNormalFooter {}

class RefreshAutoFooter: MJRefreshAutoFooter {}

class RefreshTipKissFooter: MJRefreshBackFooter {}
