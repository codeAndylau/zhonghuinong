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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        
        navigationItem.leftBarButtonItem = cartItem
        //navigationItem.rightBarButtonItem = messageItem
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CartTabCell.self, forCellReuseIdentifier: CartTabCell.identifier)
        
        debugPrints("--- \(CartTabCell.identifier)")        
        
        if isEmpty {
           tableView.addSubview(emptyView)
        }
        
        view.addSubview(settleView)
        
        settleView.settlementBtn.rx.tap.subscribe(onNext: { [weak self] in
            debugPrints("button Tapped")
            let order = OrderViewController()
            self?.navigationController?.pushViewController(order, animated: true)
        }).disposed(by: rx.disposeBag)

    }
    
    // MARK: - Lazy

    lazy var cartItem = BarButtonItem.cartItem()
    lazy var emptyView = CartEmptyView.loadView()
    lazy var settleView = SettlementView.loadView()
    lazy var sectionView = CartSectionHeaderView.loadView()
    lazy var messageItem = BarButtonItem(image: UIImage(named: "mine_messge"), target: self, action: #selector(messageAction))
    
    
    // MARK: - Public methods
    
    @objc func messageAction() {
        debugPrints("消息")
        sectionView.titleLab.text = "共12件商品"
    }

}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTabCell.identifier, for: indexPath) as! CartTabCell
        cell.selectionStyle = .none
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
