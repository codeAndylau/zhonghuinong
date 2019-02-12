//
//  OrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class OrderViewController: TableViewController {

    lazy var paySelectDemo = PaySelectViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        navigationItem.title = "确认订单"
        tableView.backgroundColor = Color.backdropColor
        tableView.tableHeaderView = headerView
        
        headerView.selectBtn.rx.tap.subscribe(onNext: { [weak self] in
            debugPrints("点击了支付方式")
            self?.paySelectDemo.show()
        }).disposed(by: rx.disposeBag)
    }
    
    // MARK: - Lazy
    
    lazy var headerView = OrderHeaderView.loadView()
    
    
    // MARK: - Public methods
}
