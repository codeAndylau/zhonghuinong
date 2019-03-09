//
//  MineAllOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import JXCategoryView

class MineAllOrderViewController: ViewController {

    override func makeUI() {
        super.makeUI()
        view.addSubview(tableView)
    }

    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lazy
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-kNavBarH-44), style: .plain)
        view.backgroundColor = UIColor.hexColor(0xFAFAFA)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.register(MineOrderTabCell.self, forCellReuseIdentifier: MineOrderTabCell.identifier)
        return view
    }()
}

extension MineAllOrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineOrderTabCell.identifier, for: indexPath) as! MineOrderTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
}


extension MineAllOrderViewController: JXCategoryListContentViewDelegate {
    
    func listView() -> UIView { return self.view }
    func listDidAppear() {}
    func listDidDisappear() {}
}
