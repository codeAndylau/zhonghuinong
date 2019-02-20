//
//  FarmNonMemberViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 农场非会员
class FarmNonMemberViewController: TableViewController {

    var isMember = false
    
    lazy var topView: FarmNonmembersHeaderView = {
        let view = FarmNonmembersHeaderView()
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 650)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tableView.tableHeaderView = topView
        statusBarStyle.accept(true)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        // 切换bool值
        isMember.toggle()
        bringLayertoFront()
    }

}

extension FarmNonMemberViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
}
