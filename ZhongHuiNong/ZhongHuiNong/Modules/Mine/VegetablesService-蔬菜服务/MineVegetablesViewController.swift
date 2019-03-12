//
//  MineVegetablesViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineVegetablesViewController: TableViewController {

    override func makeUI() {
        super.makeUI()
        navigationItem.title = localized("蔬菜服务")
        
        if User.hasUser() && User.currentUser().isVip == 0 {
            
            let emptyView = EmptyView()
            view.addSubview(emptyView)
            emptyView.config = EmptyViewConfig(title: "您暂不是会员用户,还没有该项服务", image: UIImage(named: "farm_delivery_nonmember"), btnTitle: "去开通")
            emptyView.snp.makeConstraints { (make) in
                make.top.equalTo(kNavBarH)
                make.left.bottom.right.equalTo(self.view)
            }
            emptyView.sureBtnClosure = {
                let phone = linkMan  // 填写运营人员的电话号码
                callUpWith(phone)
            }
        }else {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableHeaderView = headerView
            tableView.tableFooterView = nomoreView
            tableView.register(MineWalletTabCell.self, forCellReuseIdentifier: MineWalletTabCell.identifier)
        }
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lzay
    lazy var headerView = MineVegetablesHeaderView.loadView()
    lazy var nomoreView = NoMoreFooterView.loadView()
}

extension MineVegetablesViewController: UITableViewDataSource, UITableViewDelegate {
    
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
