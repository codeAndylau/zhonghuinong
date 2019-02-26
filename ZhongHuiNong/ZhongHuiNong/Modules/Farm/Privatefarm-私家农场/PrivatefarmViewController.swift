//
//  PrivatefarmViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 私家农场
class PrivatefarmViewController: ViewController {

    lazy var dataArray = [
        PrivatefarmCropsModel(color: 0x0BC7D8, title: "水份", total: 35.6, unit: "ppi", start: "0%", end: 100),
        PrivatefarmCropsModel(color: 0xFF7477, title: "温度", total: 18.8, unit: "℃", start: "0℃", end: 60),
        PrivatefarmCropsModel(color: 0x16C6A3, title: "二氧化碳", total: 524, unit: "ppm", start: "350ppm", end: 1000),
        PrivatefarmCropsModel(color: 0xF6C93B, title: "光照", total: 2799, unit: "lux", start: "0lux", end: 10000)
    ]
    
    
    override func makeUI() {
        super.makeUI()
        
        extendedLayoutIncludesOpaqueBars = true
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        navigationItem.titleView = titleView
        view.addSubview(tableView)        
    }

    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lazy
    
    lazy var titleView = PrivatefarmTitleView.loadView()
    lazy var headerView = PrivatefarmHeaderView.loadView()

    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH), style: .plain)
        view.backgroundColor = UIColor.white
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.tableHeaderView = headerView
        view.register(PrivatefarmTabCell.self, forCellReuseIdentifier: PrivatefarmTabCell.identifier)
        return view
    }()

}

extension PrivatefarmViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PrivatefarmTabCell.identifier, for: indexPath) as! PrivatefarmTabCell
        cell.model = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
