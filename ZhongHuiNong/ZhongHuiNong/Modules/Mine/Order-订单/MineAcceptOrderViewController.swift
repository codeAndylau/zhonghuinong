//
//  MineAcceptOrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

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
    }

    override func bindViewModel() {
        super.bindViewModel()
        fetchAcceptOrder()
    }
    
    // MARK: - Action
    
    func fetchAcceptOrder(isRefresh: Bool = false) {
        
        var params = [String: Any]()
        params["user_id"] = 3270
        params["status"] = 8  // 这是从小程序端来的数据。 0：待付款； 1：待发货； 2：待收货； 3：待评价； 4：已完成；
        params["wid"] = 1
        
        WebAPITool.requestModelArrayWithData(WebAPI.fetchUserOrderList(params), model: MineGoodsOrderInfo.self, complete: { (list) in
            if isRefresh {
                self.acceptOrderList.removeAll()
                self.tableView.uHead.endRefreshing()
            }
            self.acceptOrderList = list
        }) { (error) in
            debugPrints("获取所有订单失败---\(error)")
            ZYToast.showCenterWithText(text: "服务器正在高速运转")
            if isRefresh {
                self.tableView.uHead.endRefreshing()
            }
        }
    }

}

extension MineAcceptOrderViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acceptOrderList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineAcceptOrderTabCell.identifier, for: indexPath) as! MineAcceptOrderTabCell
        cell.acceptOrder = acceptOrderList[indexPath.row]
        
        cell.cancelBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.navigator.show(segue: .mineLogistics, sender: topVC)
        }).disposed(by: rx.disposeBag)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
