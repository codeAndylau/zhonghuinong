//
//  OrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class OrderViewController: TableViewController {

    var goodsList: [GoodsInfo] = [] {
        didSet {
            debugPrints("购物车的个数---\(goodsList)---\(goodsList.count)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        navigationItem.title = localized("确认订单")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = Color.backdropColor
        tableView.tableHeaderView = headerView
        tableView.register(VegetableTabCell.self, forCellReuseIdentifier: VegetableTabCell.identifier)
        
        tableView.addSubview(paySureView)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        paySureView.sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.paySelectDemo.show()
        }).disposed(by: rx.disposeBag)
        
    }
    
    // MARK: - Lazy
    lazy var headerView = OrderHeaderView.loadView()
    lazy var paySureView = PaySureView.loadView()
    lazy var paySelectDemo = PaySelectViewController()
    
    
    // MARK: - Public methods
}

extension OrderViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VegetableTabCell.identifier, for: indexPath) as! VegetableTabCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100+4*60+14
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        paySureView.frame = CGRect(x: 0, y: kScreenH-kBottomViewH+offsetY, width: kScreenW, height: kBottomViewH)
    }

}
