//
//  FlashOneViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class FlashOneViewController: ViewController {

    override func makeUI() {
        super.makeUI()
        view.addSubview(tableView)
    }
    
    override func updateUI() {
        super.updateUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lazy
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-FlashViewH-15), style: .plain)
        view.backgroundColor = UIColor.white
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.register(FlashOneTabCell.self, forCellReuseIdentifier: FlashOneTabCell.identifier)
        return view
    }()

}

extension FlashOneViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlashOneTabCell.identifier, for: indexPath) as! FlashOneTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
