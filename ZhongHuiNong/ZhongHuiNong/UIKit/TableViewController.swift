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

class TableViewController: ViewController {

    let headerRefreshTrigger = PublishSubject<Void>()
    let footerRefreshTrigger = PublishSubject<Void>()
    
    let isHeaderLoading = BehaviorRelay(value: false)
    let isFooterLoading = BehaviorRelay(value: false)
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(), style: .plain)
        //        view.emptyDataSetSource = self
        //        view.emptyDataSetDelegate = self
        return view
    }()
    
    var clearsSelectionOnViewWillAppear = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func makeUI() {
        super.makeUI()
        
        stackView.spacing = 0
        stackView.addArrangedSubview(tableView)
        
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
        
        tableView.footRefreshControl.autoRefreshOnFoot = true
        
//        let updateEmptyDataSet = Observable.of(isLoading.mapToVoid().asObservable(), emptyDataSetImageTintColor.mapToVoid()).merge()
//        updateEmptyDataSet.subscribe(onNext: { [weak self] () in
//            self?.tableView.reloadEmptyDataSet()
//        }).disposed(by: rx.disposeBag)
        
    }
    
    override func updateUI() {
        super.updateUI()
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

