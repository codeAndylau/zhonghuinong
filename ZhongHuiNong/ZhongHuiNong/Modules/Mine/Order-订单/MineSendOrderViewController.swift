//
//  MineSendOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineSendOrderViewController: MineAllOrderViewController {

    var sendOrderList: [MineGoodsOrderInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func makeUI() {
        super.makeUI()
        tableView.register(MineSendOrderTabCell.self, forCellReuseIdentifier: MineSendOrderTabCell.identifier)
        tableView.uHead = MJDIYHeader(refreshingBlock: {
            self.fetchSendOrder(isRefresh: true)
        })
    }

    override func bindViewModel() {
        super.bindViewModel()
        fetchSendOrder()
    }
    
    // MARK: - Action
    
    func fetchSendOrder(isRefresh: Bool = false) {
        
        var params = [String: Any]()
        params["user_id"] = User.currentUser().userId
        params["status"] = 1  // 这是从小程序端来的数据。 0：待付款； 1：待发货； 2：待收货； 3：待评价； 4：已完成；
        params["wid"] = 1
        
        WebAPITool.requestModelArrayWithData(WebAPI.fetchUserOrderList(params), model: MineGoodsOrderInfo.self, complete: { (list) in
            if isRefresh {
                self.tableView.uHead.endRefreshing()
                self.sendOrderList.removeAll()
            }
            self.sendOrderList = list
        }) { (error) in
            debugPrints("获取所有订单失败---\(error)")
            self.sendOrderList = []
            //ZYToast.showCenterWithText(text: "服务器正在高速运转")
            if isRefresh {
                self.tableView.uHead.endRefreshing()
            }
        }
    }

}

extension MineSendOrderViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sendOrderList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineSendOrderTabCell.identifier, for: indexPath) as! MineSendOrderTabCell
        // orderstatus, 1待付款（可以取消订单），  2, 待发货或者待收货， 3 待评价，已完成
        // paymentstatus =1 未支付， =2 已支付，  expressstatus = 1未发货，  =2 已发货
        cell.sendOrder = sendOrderList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
