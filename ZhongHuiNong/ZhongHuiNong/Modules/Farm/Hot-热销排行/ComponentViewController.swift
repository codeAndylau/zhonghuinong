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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
        self.navigator.show(segue: .goodsDetail(id: 95), sender: topVC)
    }
    
}

extension ComponentViewController: JXCategoryListContentViewDelegate {
    
    func listView() -> UIView { return self.view }
    func listDidAppear() {}
    func listDidDisappear() {}
}

