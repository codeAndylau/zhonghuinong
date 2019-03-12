//
//  DeliveryOrderInfoViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/20.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryOrderInfoViewController: ViewController {

    var page: Int = 1
    
    /// 判断当前用户是否已经选择过蔬菜了
    var vegetablesInfo: [DispatchVegetablesInfo] = [] {
        didSet {
            
            if vegetablesInfo.count > 0 {
                mainQueue {
                   self.tableView.reloadData()
                }
            }else {
                let emptyView = EmptyView()
                view.addSubview(emptyView)
                emptyView.config = EmptyViewConfig(title: "您暂时没有历史配送蔬菜订单信息", image: UIImage(named: "farm_delivery_nonmember"), btnTitle: "确认")
                emptyView.snp.makeConstraints { (make) in
                    make.top.equalTo(kNavBarH)
                    make.left.bottom.right.equalTo(self.view)
                }
                emptyView.sureBtnClosure = {
                   self.navigationController?.popViewController(animated: true)
                }
                
            }
        }
    }
    
    override func makeUI() {
        super.makeUI()
        
        navigationItem.title = "配送历史订单"
        view.addSubview(tableView)
        
        fetchDispatchOrderList()
    }

    override func bindViewModel() {
        super.bindViewModel()
    }
    
    
    // MAKR: - Lazy
    
    lazy var footerView = UIView()
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH), style: .plain)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.tableFooterView = footerView
        view.showsVerticalScrollIndicator = false
        view.register(DeliveryOrderInfoTabCell.self, forCellReuseIdentifier: DeliveryOrderInfoTabCell.identifier)
        
        view.uHead = MJDIYHeader(refreshingBlock: {
            self.page = 1
            self.fetchDispatchOrderList()
        })
        
        view.uFoot =  MJDIYAutoFooter(refreshingBlock: {
            self.page += 1
            self.fetchDispatchOrderList()
        })
        
        return view
    }()
    
    
    
    // MARK: - Method
    
    /// 获取配送订单列表（正在进行中，历史记录）
    func fetchDispatchOrderList() {
        
        var params = [String: Any]()
        params["userid"] = User.currentUser().userId
        params["status"] = 2  // status 1 等于在正在进行中的订单， status 2 是历史订单
        params["pageSize"] = 10
        params["pageIndex"] = page
        
        WebAPITool.requestModelArrayWithData(WebAPI.dispatchOrderList(params), model: DispatchVegetablesInfo.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            self.tableView.uHead.endRefreshing()
            self.tableView.uFoot.endRefreshing()
            
            if self.page > 1 {
                self.vegetablesInfo += list
            }else {
                self.vegetablesInfo.removeAll()
                self.vegetablesInfo = list
            }

        }) { (error) in
            self.vegetablesInfo = []
            self.tableView.uHead.endRefreshing()
            self.tableView.uFoot.endRefreshing()
            debugPrints("获取配送订单列表（正在进行中，历史记录）失败---\(error)")
        }
    }


}

extension DeliveryOrderInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vegetablesInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryOrderInfoTabCell.identifier, for: indexPath) as! DeliveryOrderInfoTabCell
        cell.info = vegetablesInfo[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}

