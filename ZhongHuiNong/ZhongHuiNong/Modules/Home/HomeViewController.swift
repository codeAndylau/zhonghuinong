//
//  HomeViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: TableViewController {
    
    lazy var viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        navigationItem.title = HomeViewController.homeTitle
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.resueIdentifier)
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        isRefresh.accept(true)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = HomeViewModel.Input(loadRefresh: Observable.just(()), headerRefresh: headerRefreshTrigger, footerRefresh: footerRefreshTrigger)
        
        let output = viewModel.transform(input: input)
        
        viewModel.loading.asObservable().bind(to: isLoading).disposed(by: rx.disposeBag)
        viewModel.headerLoading.asObservable().bind(to: isHeaderLoading).disposed(by: rx.disposeBag)
        viewModel.footerLoading.asObservable().bind(to: isFooterLoading).disposed(by: rx.disposeBag)

        output.items.asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: HomeTableViewCell.resueIdentifier, cellType: HomeTableViewCell.self)) {
                tableView, model, cell in
                cell.bind(to: model)
            }.disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(HomePublicityEntity.self).subscribe(onNext: { (item) in
            debugPrints("mmp---\(item.texts)")
            
        }).disposed(by: rx.disposeBag)
        
        isLoading.subscribe(onNext: { (flag) in
            debugPrints("正在加载数据---\(flag)")
        }).disposed(by: rx.disposeBag)
        
    }

}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension HomeViewController {
    static let homeTitle = localized("公示公告")    
}
