//
//  TableViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import KafkaRefresh
import SnapKit

class TableViewController: ViewController {
    
    let headerRefreshTrigger = PublishSubject<Void>()
    let footerRefreshTrigger = PublishSubject<Void>()
    
    let isHeaderLoading = BehaviorRelay(value: false)
    let isFooterLoading = BehaviorRelay(value: false)
    
    let isRefresh = BehaviorRelay(value: false)
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect.zero, style: .grouped)
        self.view.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        //        view.emptyDataSetSource = self
        //        view.emptyDataSetDelegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        tableView.backgroundColor = .white
        isRefresh.asObservable().subscribe(onNext: { [weak self] (flag) in
            guard let self = self else { return }
            if flag { self.refreshTrigger() }
        }).disposed(by: rx.disposeBag)
    }
    
    override func updateUI() {
        super.updateUI()
    }
    
    func bringLayertoFront() {
        extendedLayoutIncludesOpaqueBars = true
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    func refreshTrigger() {
        /// 数据刷新
        tableView.bindGlobalStyle(forHeadRefreshHandler: { [weak self] in
            if self?.tableView.headRefreshControl.isTriggeredRefreshByUser == false {
                self?.headerRefreshTrigger.onNext(())
            }
        })
        
        tableView.bindGlobalStyle(forFootRefreshHandler: { [weak self] in
            self?.footerRefreshTrigger.onNext(())
        })
        
        isHeaderLoading.bind(to: tableView.headRefreshControl.rx.isAnimating).disposed(by: rx.disposeBag)
        isFooterLoading.bind(to: tableView.footRefreshControl.rx.isAnimating).disposed(by: rx.disposeBag)
        
        tableView.footRefreshControl.autoRefreshOnFoot = false
        
        //        let updateEmptyDataSet = Observable.of(isLoading.mapToVoid().asObservable(), emptyDataSetImageTintColor.mapToVoid()).merge()
        //        updateEmptyDataSet.subscribe(onNext: { [weak self] () in
        //            self?.tableView.reloadEmptyDataSet()
        //        }).disposed(by: rx.disposeBag)
    }
    
}

extension TableViewController {
    func deselectSelectedRow() {
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            selectedIndexPaths.forEach({ (indexPath) in
                tableView.deselectRow(at: indexPath, animated: false)
            })
        }
    }
}

