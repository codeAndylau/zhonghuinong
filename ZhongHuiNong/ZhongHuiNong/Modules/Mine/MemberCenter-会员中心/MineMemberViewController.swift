//
//  MineMemberViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineMemberViewController: TableViewController {

    override func makeUI() {
        super.makeUI()
        navigationItem.title = localized("会员中心")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.register(MineWalletTabCell.self, forCellReuseIdentifier: MineWalletTabCell.identifier)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lzay
    lazy var headerView = MineVegetablesHeaderView.loadView()
    lazy var nomoreView = NoMoreFooterView.loadView()
}

extension MineMemberViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineWalletTabCell.identifier, for: indexPath) as! MineWalletTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    
}
