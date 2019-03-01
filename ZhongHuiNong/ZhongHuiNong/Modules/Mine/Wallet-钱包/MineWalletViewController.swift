//
//  MineWalletViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineWalletViewController: TableViewController {

    override func makeUI() {
        super.makeUI()
        navigationItem.title = localized("钱包")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = nomoreView
        tableView.register(MineWalletTabCell.self, forCellReuseIdentifier: MineWalletTabCell.identifier)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lzay
    lazy var headerView = MineWalletHeaderView.loadView()
    lazy var nomoreView = NoMoreFooterView.loadView()
}

extension MineWalletViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineWalletTabCell.identifier, for: indexPath) as! MineWalletTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    
}
