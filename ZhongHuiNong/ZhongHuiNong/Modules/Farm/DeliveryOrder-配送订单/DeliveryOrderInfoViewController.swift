//
//  DeliveryOrderInfoViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/20.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryOrderInfoViewController: ViewController {

    override func makeUI() {
        super.makeUI()
        navigationItem.title = "配送订单"
        view.addSubview(tableView)
    }

    override func bindViewModel() {
        super.bindViewModel()
    }
    
    
    // MAKR: - Lazy
    
    lazy var footerView = UIView()
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH), style: .plain)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.tableFooterView = footerView
        view.showsVerticalScrollIndicator = false
        view.register(DeliveryOrderInfoTabCell.self, forCellReuseIdentifier: DeliveryOrderInfoTabCell.identifier)
        return view
    }()


}

extension DeliveryOrderInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryOrderInfoTabCell.identifier, for: indexPath) as! DeliveryOrderInfoTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}

