//
//  MineLogisticsViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineLogisticsViewController: ViewController {

    override func makeUI() {
        super.makeUI()
        navigationItem.title = "物流信息"
        view.addSubview(tableView)
    }

    override func bindViewModel() {
        super.bindViewModel()
    }

    
    // MARK: - Lazy
    
    lazy var headerView = MineLogisticsHeaderView.loadView()
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH), style: .plain)
        view.backgroundColor = UIColor.hexColor(0xFAFAFA)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.register(MineLogisticsTablCell.self, forCellReuseIdentifier: MineLogisticsTablCell.identifier)
        view.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        view.estimatedRowHeight = 100
        view.rowHeight = UITableView.automaticDimension
        view.tableHeaderView = headerView
        return view
    }()
    
    lazy var dataArray = ["【东莞市】 快件离开 【虎门中心】 已发往 【成都中转】",
                          "【东莞市】 快件已经到达 【虎门中心】",
                          "【深圳市】 快件离开 【深圳公明】 已发往 【成都中转】",
                          "【深圳市】 【深圳公明】（0755-27688055、0755-27688066） 的 客户马山头38栋 （13800138009） 已揽收"
                          ]
    
}

extension MineLogisticsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineLogisticsTablCell.identifier, for: indexPath) as! MineLogisticsTablCell
        cell.titleLab.text = dataArray[indexPath.row]
        
        if indexPath.row == 0 {
            cell.isCurrented = true
            cell.isDownLine = true
            cell.isCurrented = true
            cell.isUpCorner = true
        }else if indexPath.row == dataArray.count - 1 {
            cell.isDownCorner = true
            cell.isUpLine = true
            cell.isDownLine = false
        }else{
            cell.isCurrented = false
            cell.isUpLine = true
            cell.isDownLine = true
        }

        return cell
    }
    
}
