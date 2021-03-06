//
//  MinePayOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import MBProgressHUD

/// 代付款
class MinePayOrderViewController: MineAllOrderViewController {

    var balance: UserBanlance = UserBanlance()
    
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
        
        tableView.setEmpty(view: EmptyStore.orderEmpty(block: {
            topVC?.navigationController?.popToRootViewController(animated: false)
            topVC?.tabBarController?.selectedIndex = 1
        }))
    }

    override func bindViewModel() {
        super.bindViewModel()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchBalance()
        fetchPayOrder()
    }
    
    lazy var payDemo = PayPasswordViewController()
    
    
    // MARK: - Action

    func fetchBalance() {
        
        let params = ["userid": User.currentUser().userId]
        
        WebAPITool.requestModel(WebAPI.userBalance(params), model: UserBanlance.self, complete: { (model) in
            self.tableView.uHead.endRefreshing()
            self.balance = model
        }) { (error) in
            self.tableView.uHead.endRefreshing()
        }
        
    }
    
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
            
            // 按照时间排序
            self.payOrderList = list.sorted(by: { (item1, item2) -> Bool in
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
                
                let date1Str = item1.add_time.replacingOccurrences(of: "T", with: " ")
                let date2Str = item2.add_time.replacingOccurrences(of: "T", with: " ")
                
                let date1 = dateFormatter.date(from: date1Str)
                let date2 = dateFormatter.date(from: date2Str)
                
                if date1 != nil && date2 != nil {
                    return date1!.compare(date2!) == .orderedDescending
                }else {
                    return false
                }
            })

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
        
        debugPrint("取消订单的参数---\(params)")
        
        WebAPITool.request(WebAPI.cancelOrder(params), complete: { (value) in
            let status = value["status"].intValue
            let detail = value["detail"].stringValue
            if status == 1 {
                ZYToast.showCenterWithText(text: "取消订单成功")
                
                /// 删除某一条数据
                self.tableView.beginUpdates()
                self.payOrderList.remove(at: indexPath.row)
                let index = IndexPath(row: indexPath.row, section: 0)
                self.tableView.deleteRows(at: [index], with: .none)
                self.tableView.endUpdates()
            }else{
                ZYToast.showCenterWithText(text: detail)
            }
        }) { (error) in
            ZYToast.showCenterWithText(text: "取消订单失败")
            debugPrints("确认收货失败 ----- \(error)")
        }
    }
    
    func payOrder(_ orderId: String, amountReal: Double, indexPath: IndexPath) {
        
        debugPrint("商品价格--用户账户余额---\(amountReal)---\(balance.creditbalance)")
        
        guard amountReal < balance.creditbalance else {
            MBProgressHUD.showInfo("您的余额不足")
            return
        }
        
        payDemo.paySureView.payLab.text = "¥\(amountReal)"
        payDemo.order_no = orderId
        payDemo.show()
        payDemo.paySuccessClosure = { [weak self] in
            
            /// 删除某一条数据
            self?.tableView.beginUpdates()
            self?.payOrderList.remove(at: indexPath.row)
            let index = IndexPath(row: indexPath.row, section: 0)
            self?.tableView.deleteRows(at: [index], with: .none)
            self?.tableView.endUpdates()
            
            NotificationCenter.default.post(name: .cartOrderPaySuccess, object: nil)
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
            
            let info = self.payOrderList[indexPath.row]
            debugPrints("点击了第\(index)---\(info.orderNumber)个")
            
            if index == 1 {
                self.cancelOrder(info.orderNumber, indexPath: indexPath)
            }
            
            if index == 2 {
                self.payOrder(info.orderNumber, amountReal: info.amountReal, indexPath: indexPath)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}

