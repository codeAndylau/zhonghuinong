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
    var isData = true
    
    /// 历史菜单
    var vegetablesInfo: [DispatchVegetablesInfo] = [] {
        didSet {
            mainQueue {
                self.emptyData()
            }
        }
    }
    
    /// 正在进行的菜单
    var historyInfo: [DispatchVegetablesInfo] = [] {
        didSet {
            mainQueue {
                self.emptyData()
            }
        }
    }
    
    func emptyData() {
        
        guard vegetablesInfo.count == 0 && historyInfo.count == 0 else {
            self.tableView.reloadData()
            return
        }
        
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
    
    override func makeUI() {
        super.makeUI()
        
        navigationItem.title = "配送历史订单"
        view.addSubview(tableView)
        
        fetchDispatchOrderList(1)
        fetchDispatchOrderList(2)
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
            self.isData = true
            self.tableView.uFoot.isHidden = false
            self.tableView.uFoot.resetNoMoreData()
            self.fetchDispatchOrderList(1)
            self.fetchDispatchOrderList(2)
        })
        
        view.uFoot =  MJDIYAutoFooter(refreshingBlock: {
            self.page += 1
            self.fetchDispatchOrderList(2)
        })
        
        return view
    }()
    
    
    
    // MARK: - Method
    
    /// 获取配送订单列表（正在进行中，历史记录）
    func fetchDispatchOrderList(_ status: Int) {
        
        var params = [String: Any]()
        params["userid"] = User.currentUser().userId
        params["status"] = status // status 1 等于在正在进行中的订单， status 2 是历史订单
        params["pageSize"] = 10
        params["pageIndex"] = page
        
        WebAPITool.requestModelArrayWithData(WebAPI.dispatchOrderList(params), model: DispatchVegetablesInfo.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            self.tableView.uHead.endRefreshing()
            self.tableView.uFoot.endRefreshing()
            
            /// 获取的是正在进行的
            if status == 1 {
                self.historyInfo.removeAll()
                self.historyInfo = list
            }
            
            /// 获取的是正在进行的
            if status == 2 {
                
                if list.count < 10 {
                    self.isData = false
                    self.tableView.uFoot.endRefreshingWithNoMoreData()
                    self.tableView.uFoot.isHidden = true
                    self.tableView.reloadData()
                }
                
                if self.page > 1 {
                    self.vegetablesInfo += list
                }else {
                    self.vegetablesInfo.removeAll()
                    self.vegetablesInfo = list
                }
            }

        }) { (error) in
            self.vegetablesInfo = []
            self.historyInfo = []
            self.tableView.uHead.endRefreshing()
            self.tableView.uFoot.endRefreshing()
            debugPrints("获取配送订单列表（正在进行中，历史记录）失败---\(error)")
        }
    }


}

extension DeliveryOrderInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return historyInfo.count
        }
        return vegetablesInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryOrderInfoTabCell.identifier, for: indexPath) as! DeliveryOrderInfoTabCell
        if indexPath.section == 0 {
            cell.finishLab.text = "进行中"
            cell.info = historyInfo[indexPath.row]
        }else {
            cell.finishLab.text = "已完成"
            cell.info = vegetablesInfo[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 && isData == false {
            return 50
        }
        return  0.01
    }
    
    //将分组尾设置为一个空的View
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 && isData == false {
            let view = NoMoreFooterView.loadView()
            view.titleLab.text = "没有更多了~"
            return view
        }
        return UIView()
    }
    
}

