//
//  MinePayOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MinePayOrderViewController: MineAllOrderViewController {

    var payOrderList: [MineGoodsOrderInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func makeUI() {
        super.makeUI()
        tableView.register(MinePayOrderTabCell.self, forCellReuseIdentifier: MinePayOrderTabCell.identifier)
        tableView.uHead = MJDIYHeader(refreshingBlock: {
            self.fetchPayOrder(isRefresh: true)
        })
    }

    override func bindViewModel() {
        super.bindViewModel()
        fetchPayOrder()
    }
    
    // MARK: - Action

    func fetchPayOrder(isRefresh: Bool = false) {
        var params = [String: Any]()
        params["user_id"] = 3260
        params["status"] = 8  // 这是从小程序端来的数据。 0：待付款； 1：待发货； 2：待收货； 3：待评价； 4：已完成；
        params["wid"] = 1
        
        WebAPITool.requestModelArrayWithData(WebAPI.fetchUserOrderList(params), model: MineGoodsOrderInfo.self, complete: { (list) in
            if isRefresh {
                self.tableView.uHead.endRefreshing()
                self.payOrderList.removeAll()
            }
            self.payOrderList = list
        }) { (error) in
            debugPrints("获取所有订单失败---\(error)")
            ZYToast.showCenterWithText(text: "服务器正在高速运转")
            if isRefresh {
                self.tableView.uHead.endRefreshing()
            }
        }
    }
}

extension MinePayOrderViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payOrderList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MinePayOrderTabCell.identifier, for: indexPath) as! MinePayOrderTabCell
        cell.payOrder = payOrderList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
