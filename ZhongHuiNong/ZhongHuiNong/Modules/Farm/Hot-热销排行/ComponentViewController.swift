//
//  ComponentViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/26.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import JXCategoryView

class ComponentViewController: ViewController {

    override func makeUI() {
        super.makeUI()
        view.backgroundColor = UIColor.randomColor()
        view.addSubview(tableView)
    }

    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lazy
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-kNavBarH-44-kBottomViewH), style: .plain)
        view.backgroundColor = UIColor.white
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.register(HotTabCell.self, forCellReuseIdentifier: HotTabCell.identifier)
        return view
    }()
    
}

extension ComponentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HotTabCell.identifier, for: indexPath) as! HotTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigator.show(segue: .goodsDetail, sender: self.topMost)
    }
    
}

extension ComponentViewController: JXCategoryListContentViewDelegate {
    
    // 返回列表视图 如果列表是VC，就返回VC.view  如果列表是View，就返回View自己
    func listView() -> UIView! {
        return self.view
    }
    
    //可选使用，列表显示的时候调用
    func listDidAppear() { }
    
    //可选使用，列表消失的时候调用
    func listDidDisappear() { }
}

