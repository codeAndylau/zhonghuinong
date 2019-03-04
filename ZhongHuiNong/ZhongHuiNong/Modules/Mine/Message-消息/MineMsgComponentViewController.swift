//
//  MineMsgComponentViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/26.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import JXCategoryView

class MineMsgComponentViewController: ViewController {

    override func makeUI() {
        super.makeUI()
        view.backgroundColor = UIColor.randomColor()
        view.addSubview(tableView)
    }
    
    //  MARK: - Lazy
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-kNavBarH-44), style: .plain)
        view.backgroundColor = UIColor.white
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.register(HotTabCell.self, forCellReuseIdentifier: HotTabCell.identifier)
        return view
    }()
    
}

extension MineMsgComponentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HotTabCell.identifier, for: indexPath) as! HotTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigator.show(segue: .goodsDetail, sender: topVC)
    }
    
}

extension MineMsgComponentViewController: JXCategoryListContentViewDelegate {
    func listView() -> UIView { return view }
    func listDidAppear() { }
    func listDidDisappear() { }
}
