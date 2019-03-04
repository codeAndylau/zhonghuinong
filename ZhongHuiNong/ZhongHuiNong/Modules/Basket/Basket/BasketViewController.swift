//
//  BasketViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/24.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class BasketViewController: TableViewController {

    var isEmpty = false
    var num = 0

    override func makeUI() {
        super.makeUI()
        
        navigationItem.leftBarButtonItem = cartItem
        navigationItem.rightBarButtonItem = messageItem
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CartTabCell.self, forCellReuseIdentifier: CartTabCell.identifier)
        tableView.uempty = UEmptyView(verticalOffset: -kNavBarH, tapClosure: {
            [weak self] in self?.loadData(true)
        }) 
        view.addSubview(settleView)
    }

    override func bindViewModel() {
        super.bindViewModel()
        
        settleView.settlementBtn.rx.tap.subscribe(onNext: { [weak self] in
            debugPrints("button Tapped")
            let order = OrderViewController()
            self?.navigationController?.pushViewController(order, animated: true)
        }).disposed(by: rx.disposeBag)
        
        loadData()
    }
    
    func loadData(_ more: Bool = false) {
        tableView.uempty?.allowShow = true
        if more {
            num = 3
            tableView.reloadData()
        }
        
    }
    
    // MARK: - Lazy
    lazy var cartItem = BarButtonItem.cartItem()
    lazy var emptyView = CartEmptyView.loadView()
    lazy var settleView = SettlementView.loadView()
    lazy var sectionView = CartSectionHeaderView.loadView()
    lazy var messageItem = BarButtonItem(image: UIImage(named: "mine_messge"), target: self, action: #selector(messageAction))
    
    // MARK: - Public methods
    
    @objc func messageAction() {
        sectionView.titleLab.text = "共12件商品"
    }

}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTabCell.identifier, for: indexPath) as! CartTabCell
        cell.selectionStyle = .none
        
        if indexPath.row == 2 {
            cell.selectBtn.setImage(UIImage(named: "mine_order_selected"), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
