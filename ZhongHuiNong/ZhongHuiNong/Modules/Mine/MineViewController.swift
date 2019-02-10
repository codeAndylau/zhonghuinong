//
//  MineViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/24.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineViewController: TableViewController {

    let addImg = UIButton().then { (btn) in
        btn.setImage(UIImage(named: "farm_add")!, for: .normal)
    }
    
    lazy var rightAddItem = BarButtonItem(customView: addImg)
    
    lazy var headerView = MineHeaderView.loadView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        
        navigationItem.rightBarButtonItems = [rightAddItem, rightAddItem]
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.register(MineTabCell.self, forCellReuseIdentifier: MineTabCell.identifier)
    }
    
}


extension MineViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineTabCell.identifier, for: indexPath) as! MineTabCell
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }    
    
}
