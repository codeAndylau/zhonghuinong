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

    var orderList: [MineGoodsOrderInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func makeUI() {
        super.makeUI()
        view.addSubview(tableView)
    }

    override func bindViewModel() {
        super.bindViewModel()
        fetchAllOrder()
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
        view.register(MinePayOrderTabCell.self, forCellReuseIdentifier: MinePayOrderTabCell.identifier)
        view.register(MineSendOrderTabCell.self, forCellReuseIdentifier: MineSendOrderTabCell.identifier)
        view.register(MineAcceptOrderTabCell.self, forCellReuseIdentifier: MineAcceptOrderTabCell.identifier)
        view.uHead = MJDIYHeader(refreshingBlock: {
            self.fetchAllOrder(isRefresh: true)
        })
        return view
    }()
    
    /// 获取所有订单
    func fetchAllOrder(isRefresh: Bool = false) {
        
        var params = [String: Any]()
        params["user_id"] = 3260
        params["status"] = 8  // 这是从小程序端来的数据。 0：待付款； 1：待发货； 2：待收货； 3：待评价； 4：已完成；
        params["wid"] = 1
        
        WebAPITool.requestModelArrayWithData(WebAPI.fetchUserOrderList(params), model: MineGoodsOrderInfo.self, complete: { (list) in
            if isRefresh {
                self.tableView.uHead.endRefreshing()
                self.orderList.removeAll()
            }
            self.orderList = list
        }) { (error) in
            debugPrints("获取所有订单失败---\(error)")
            ZYToast.showCenterWithText(text: "服务器正在高速运转")
            if isRefresh {
                self.tableView.uHead.endRefreshing()
            }
        }
    }
}

extension MineAllOrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 这是从小程序端来的数据。 0：待付款； 1：待发货； 2：待收货； 3：待评价； 4：已完成；
        let order = orderList[indexPath.row]
        
        debugPrints("o订单状态--\(indexPath.row)-\(order.status)")
        
        switch order.status {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MinePayOrderTabCell.identifier, for: indexPath) as! MinePayOrderTabCell
            cell.payOrder = order
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MineSendOrderTabCell.identifier, for: indexPath) as! MineSendOrderTabCell
            cell.sendOrder = order
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: MineAcceptOrderTabCell.identifier, for: indexPath) as! MineAcceptOrderTabCell
            cell.acceptOrder = order
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MineOrderTabCell.identifier, for: indexPath) as! MineOrderTabCell
            cell.order = order
            return cell
        }
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
