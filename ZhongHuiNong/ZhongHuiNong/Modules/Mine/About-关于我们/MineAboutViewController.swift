//
//  MineAboutViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/26.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineAboutViewController: TableViewController {

    override func makeUI() {
        super.makeUI()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.register(MineTabCell.self, forCellReuseIdentifier: MineTabCell.identifier)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        headerView.detailLab.text = Configs.App.appVersion + "." + Configs.App.appBuild
    }
    
    // MARK: - Lzay
    lazy var titleArray = ["峻铭健康简介"]
    lazy var headerView = MineAboutHeaderView.loadView()
}

extension MineAboutViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineTabCell.identifier, for: indexPath) as! MineTabCell
        cell.titleLab.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
