//
//  MineAcceptOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 待收货
class MineAcceptOrderViewController: MineAllOrderViewController {

    var acceptOrderList: [MineGoodsOrderInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func makeUI() {
        super.makeUI()

        tableView.register(MineAcceptOrderTabCell.self, forCellReuseIdentifier: MineAcceptOrderTabCell.identifier)
        tableView.uHead = MJDIYHeader(refreshingBlock: {
            self.fetchAcceptOrder(isRefresh: true)
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
        fetchAcceptOrder()
    }
    
    // MARK: - Action
    func fetchAcceptOrder(isRefresh: Bool = false) {
        
        var params = [String: Any]()
        params["user_id"] = User.currentUser().userId
        params["status"] = 2  // 这是从小程序端来的数据。 0：待付款； 1：待发货； 2：待收货； 3：待评价； 4：已完成；
        params["wid"] = 1

        WebAPITool.requestModelArrayWithData(WebAPI.fetchUserOrderList(params), model: MineGoodsOrderInfo.self, complete: { (list) in
           
            if isRefresh {
                self.acceptOrderList.removeAll()
                self.tableView.uHead.endRefreshing()
            }
            
            // 按照时间排序
            self.acceptOrderList = list.sorted(by: { (item1, item2) -> Bool in
                
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
            self.acceptOrderList = []
            if isRefresh {
                self.tableView.uHead.endRefreshing()
            }
        }
    }
    
    // 确认收货
    func orderAccept(_ orderId: String, indexPath: IndexPath) {
        
        var params = [String: Any]()
        params["order_no"] = orderId
        params["user_id"] = User.currentUser().userId
        params["wid"] = wid
        
        // 这个统一格式的返回 ，status = 1成功， 0 就是失败
        WebAPITool.request(WebAPI.userOrderReceipt(params), complete: { (value) in
            let status = value["status"].intValue
            if status == 1 {
                
                ZYToast.showCenterWithText(text: "确认收货成功")
                
                /// 删除某一条数据
                self.tableView.beginUpdates()
                self.acceptOrderList.remove(at: indexPath.row)
                let index = IndexPath(row: indexPath.row, section: 0)
                self.tableView.deleteRows(at: [index], with: .none)
                self.tableView.endUpdates()
                
            }else{
                ZYToast.showCenterWithText(text: "服务器正在高速运作中")
            }
            
        }) { (error) in
            ZYToast.showCenterWithText(text: "服务器正在高速运作中")
        }
    }

}

extension MineAcceptOrderViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acceptOrderList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineAcceptOrderTabCell.identifier, for: indexPath) as! MineAcceptOrderTabCell
        // orderstatus, 1待付款（可以取消订单），  2, 待发货或者待收货， 3 待评价，已完成
        // paymentstatus =1 未支付， =2 已支付，  expressstatus = 1未发货，  =2 已发货
   
        let info = acceptOrderList[indexPath.row]
        
        cell.acceptOrder = info
        
        cell.AcceptBtnActionClosure = { [weak self] index in
            guard let self = self else { return }
            
            debugPrints("点击的是第\(index)个")
            
            if index == 1 {
                self.navigator.show(segue: .mineLogistics(order_no: info.orderNumber), sender: topVC)
            }
            
            if index == 2 {
                debugPrints("点击了确认收货")
                let orderId = "\(self.acceptOrderList[indexPath.row])"
                self.orderAccept(orderId, indexPath: indexPath)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
