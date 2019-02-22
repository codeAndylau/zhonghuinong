//
//  MineAcceptOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineAcceptOrderViewController: MineAllOrderViewController {

    override func makeUI() {
        super.makeUI()
        tableView.register(MineAcceptOrderTabCell.self, forCellReuseIdentifier: MineAcceptOrderTabCell.identifier)
    }
    
    override func updateUI() {
        super.updateUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lazy

}

extension MineAcceptOrderViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineAcceptOrderTabCell.identifier, for: indexPath) as! MineAcceptOrderTabCell
        
        cell.cancelBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.navigator.show(segue: .mineLogistics, sender: self)
        }).disposed(by: rx.disposeBag)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
