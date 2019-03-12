//
//  MinePayOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 代付款
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
    
    lazy var payDemo = PayPasswordViewController()
    
    
    // MARK: - Action

    func fetchPayOrder(isRefresh: Bool = false) {
        var params = [String: Any]()
        params["user_id"] = User.currentUser().userId
        params["status"] = 0  // 这是从小程序端来的数据。 0：待付款； 1：待发货； 2：待收货； 3：待评价； 4：已完成；
        params["wid"] = 1
        
        WebAPITool.requestModelArrayWithData(WebAPI.fetchUserOrderList(params), model: MineGoodsOrderInfo.self, complete: { (list) in
            if isRefresh {
                self.tableView.uHead.endRefreshing()
                self.payOrderList.removeAll()
            }
            self.payOrderList = list
        }) { (error) in
            debugPrints("获取支付订单失败---\(error)")
            self.payOrderList = []
            if isRefresh {
                self.tableView.uHead.endRefreshing()
            }
        }
    }
    
    /// 取消订单
    func cancelOrder(_ orderId: String, indexPath: IndexPath) {
        
        var params = [String: Any]()
        params["order_no"] = orderId
        params["user_id"] = User.currentUser().userId
        params["wid"] = wid
        
        WebAPITool.request(WebAPI.cancelOrder(params), complete: { (value) in
            let status = value["status"].intValue
            if status == 1 {
                ZYToast.showCenterWithText(text: "取消订单成功")
                self.payOrderList.remove(at: indexPath.row)
            }else{
                ZYToast.showCenterWithText(text: "服务器正在高速运作中")
            }
        }) { (error) in
            ZYToast.showCenterWithText(text: "服务器正在高速运作中")
            debugPrints("确认收货失败 ----- \(error)")
        }
    }
    
    func payOrder(_ orderId: String) {
        payDemo.order_no = orderId
        payDemo.show()
        payDemo.paySuccessClosure = {
            
        }
    }
}

extension MinePayOrderViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payOrderList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MinePayOrderTabCell.identifier, for: indexPath) as! MinePayOrderTabCell
        // orderstatus, 1待付款（可以取消订单），  2, 待发货或者待收货， 3 待评价，已完成
        // paymentstatus =1 未支付， =2 已支付，  expressstatus = 1未发货，  =2 已发货
        cell.payOrder = payOrderList[indexPath.row]
        
        cell.btnActionClosure = { [weak self] index in
            guard let self = self else { return }
            
            let orderId = self.payOrderList[indexPath.row].orderNumber
            debugPrints("点击了第\(index)---\(orderId)个")
            
            if index == 1 {
                self.cancelOrder(orderId, indexPath: indexPath)
            }
            
            if index == 2 {
                self.payOrder(orderId)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
