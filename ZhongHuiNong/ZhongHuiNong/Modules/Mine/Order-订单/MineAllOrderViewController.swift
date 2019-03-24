//
//  MineAllOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import JXCategoryView
import MBProgressHUD

class MineAllOrderViewController: ViewController {
    
    var userBalance: UserBanlance = UserBanlance()

    var orderList: [MineGoodsOrderInfo] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func makeUI() {
        super.makeUI()
        
        view.addSubview(tableView)

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
        fetchUserBalance()
        fetchAllOrder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HudHelper.hideHUD()
    }
    
    // MARK: - Lazy
    
    lazy var payPasswordDemo = PayPasswordViewController()
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-kNavBarH-44), style: .plain)
        view.backgroundColor = UIColor.hexColor(0xFAFAFA)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
//        view.emptyDataSetSource = self
//        view.emptyDataSetDelegate = self
        view.showsVerticalScrollIndicator = false
        view.register(MineOrderTabCell.self, forCellReuseIdentifier: MineOrderTabCell.identifier)
        view.register(MinePayOrderTabCell.self, forCellReuseIdentifier: MinePayOrderTabCell.identifier)
        view.register(MineSendOrderTabCell.self, forCellReuseIdentifier: MineSendOrderTabCell.identifier)
        view.register(MineAcceptOrderTabCell.self, forCellReuseIdentifier: MineAcceptOrderTabCell.identifier)
        view.register(MineCancelOrderTabCell.self, forCellReuseIdentifier: MineCancelOrderTabCell.identifier)
        view.uHead = MJDIYHeader(refreshingBlock: {
            self.fetchAllOrder(isRefresh: true)
        })
        return view
    }()
    
    /// 获取用户的余额
    func fetchUserBalance() {
        
        let params = ["userid": User.currentUser().userId]
        WebAPITool.requestModel(WebAPI.userBalance(params), model: UserBanlance.self, complete: { (model) in
            self.tableView.uHead.endRefreshing()
            self.userBalance = model
        }) { (error) in
            self.tableView.uHead.endRefreshing()
        }
        
    }
    
    /// 获取所有订单
    func fetchAllOrder(isRefresh: Bool = false) {
        
        var params = [String: Any]()
        params["user_id"] = User.currentUser().userId
        params["status"] = 8  // 这是从小程序端来的数据。 0：待付款； 1：待发货； 2：待收货； 3：待评价； 4：已完成；
        params["wid"] = 1
        
        WebAPITool.requestModelArrayWithData(WebAPI.fetchUserOrderList(params), model: MineGoodsOrderInfo.self, complete: { (list) in
            if isRefresh {
                self.tableView.uHead.endRefreshing()
                self.orderList.removeAll()
            }
            
            // 按照时间排序
            self.orderList = list.sorted(by: { (item1, item2) -> Bool in
                
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
            debugPrints("获取所有订单失败---\(error)")
            self.orderList = []
            if isRefresh {
                self.tableView.uHead.endRefreshing()
            }
        }
    }
    
    /// 取消订单
    func cancelIndexOrder(_ orderId: String, indexPath: IndexPath) {
        
        var params = [String: Any]()
        params["order_no"] = orderId
        params["user_id"] = User.currentUser().userId
        params["wid"] = wid
        
        debugPrint("取消订单的参数---\(params)")
        
        HudHelper.showWaittingHUD(msg: "请稍后...")
        WebAPITool.request(WebAPI.cancelOrder(params), complete: { (value) in
            HudHelper.hideHUD()
            let status = value["status"].intValue
            if status == 1 {
                ZYToast.showCenterWithText(text: "取消订单成功")
                
                /// 删除某一条数据
                self.tableView.beginUpdates()
                self.orderList.remove(at: indexPath.row)
                let index = IndexPath(row: indexPath.row, section: 0)
                self.tableView.deleteRows(at: [index], with: .none)
                self.tableView.endUpdates()
                
            }else{
                ZYToast.showCenterWithText(text: "取消订单失败")
            }
        }) { (error) in
            HudHelper.hideHUD()
            ZYToast.showCenterWithText(text: "取消订单失败")
        }
    }
    
    /// 删除订单
    func deleteOrder(_ orderId: String, indexPath: IndexPath) {
        
        var params = [String: Any]()
        params["order_no"] = orderId
        params["userid"] = User.currentUser().userId
        
        debugPrints("删除订单的参数---\(params)")
        
        HudHelper.showWaittingHUD(msg: "请稍后...")
        WebAPITool.request(WebAPI.deleteOrder(params), complete: { (value) in
            HudHelper.hideHUD()
            debugPrints("删除订单失败 ----- \(value)")
            let status = value["status"].intValue
            if status == 1 {
                ZYToast.showCenterWithText(text: "删除订单成功")
                
                /// 删除某一条数据
                self.tableView.beginUpdates()
                self.orderList.remove(at: indexPath.row)
                let index = IndexPath(row: indexPath.row, section: 0)
                self.tableView.deleteRows(at: [index], with: .none)
                self.tableView.endUpdates()
                
            }else{
                ZYToast.showCenterWithText(text: "删除订单失败")
            }
        }) { (error) in
            HudHelper.hideHUD()
            ZYToast.showCenterWithText(text: "删除订单失败")
            debugPrints("删除订单失败 ----- \(error)")
        }
        
    }
    
    /// 支付订单
    func payIndexOrder(_ orderId: String, amountReal: Double, indexPath: IndexPath) {
        
        debugPrint("商品价格--用户账户余额---\(amountReal)---\(userBalance.creditbalance)")
        
        guard amountReal < userBalance.creditbalance else {
            MBProgressHUD.showInfo("您的余额不足")
            return
        }
        
        payPasswordDemo.paySureView.payLab.text = "¥\(amountReal)"
        payPasswordDemo.order_no = orderId
        payPasswordDemo.show()
        payPasswordDemo.paySuccessClosure = { [weak self] in
            /// 删除某一条数据
            self?.tableView.beginUpdates()
            self?.orderList.remove(at: indexPath.row)
            let index = IndexPath(row: indexPath.row, section: 0)
            self?.tableView.deleteRows(at: [index], with: .none)
            self?.tableView.endUpdates()
        }
    }
}

extension MineAllOrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // orderstatus, 1待付款（可以取消订单），  2, 待发货或者待收货， 3 待评价，已完成
        // paymentstatus =1 未支付， =2 已支付，  expressstatus = 1未发货，  =2 已发货
        let order = orderList[indexPath.row]
        
        debugPrints("订单状态-----\(order.status)--\(order.payment_status)")
        
        switch (order.status, order.payment_status) {

        case (1,1):
            
            /// 待支付
            let cell = tableView.dequeueReusableCell(withIdentifier: MinePayOrderTabCell.identifier, for: indexPath) as! MinePayOrderTabCell
            cell.btnActionClosure = { [weak self] index in
                guard let self = self else { return }
                
                
                debugPrints("点击了第\(index)---\(order.orderNumber)个")
                
                if index == 1 {
                    
                    let tips = SelectTipsView()
                    tips.titleLab.text = "是否取消此订单?"
                    tips.detailLab.text = ""
                    
                    tips.btnClosure = { index in
                        
                        if index == 2 {
                            self.cancelIndexOrder(order.orderNumber, indexPath: indexPath)
                        }
                    }
                }
                
                if index == 2 {
                    self.payIndexOrder(order.orderNumber, amountReal: order.amountReal, indexPath: indexPath)
                }
            }
            
            cell.payOrder = order
            return cell
            
            /// 待发货
        case (2,2):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MineSendOrderTabCell.identifier, for: indexPath) as! MineSendOrderTabCell
            cell.sendOrder = order
            return cell
            
            /// 待收货
        case (2,2):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MineAcceptOrderTabCell.identifier, for: indexPath) as! MineAcceptOrderTabCell
            cell.acceptOrder = order
            return cell
            
            /// 已经取消的订单
        case (4,_):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MineCancelOrderTabCell.identifier, for: indexPath) as! MineCancelOrderTabCell
            
            cell.order = order
            cell.btnActionClosure = {
                
                let tips = SelectTipsView()
                tips.titleLab.text = "确认删除此订单?"
                tips.detailLab.text = "删除订单后无法恢复哦"
                
                tips.btnClosure = { index in
                    
                    if index == 2 {
                        self.deleteOrder(order.orderNumber, indexPath: indexPath)
                    }
                }
            }
            
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

