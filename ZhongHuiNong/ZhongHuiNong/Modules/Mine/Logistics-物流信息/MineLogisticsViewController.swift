//
//  MineLogisticsViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineLogisticsViewController: ViewController {

    var order_no = "VB50271617760"
    
    var kuaidiInfo: KuaidiInfo = KuaidiInfo() {
        didSet {
            if kuaidiInfo.list.count > 0 {
                headerView.kuaidiInfo = kuaidiInfo
                tableView.tableHeaderView = headerView
                tableView.reloadData()
            }else {
                let emptyV = EmptyView()
                view.addSubview(emptyV)
                emptyV.config = EmptyViewConfig(title: "暂时没有获取到您的物流信息",
                                                image: UIImage(named: "farm_delivery_nonmember"),
                                                btnTitle: "确定")
                emptyV.snp.makeConstraints { (make) in
                    make.top.equalTo(kNavBarH)
                    make.left.bottom.right.equalTo(self.view)
                }
                
                emptyV.sureBtnClosure = {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    override func makeUI() {
        super.makeUI()
        navigationItem.title = "物流信息"
        view.addSubview(tableView)
    }

    override func bindViewModel() {
        super.bindViewModel()
        fetchData()
    }

    
    // MARK: - Lazy
    
    lazy var headerView = MineLogisticsHeaderView.loadView()
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH), style: .plain)
        view.backgroundColor = UIColor.hexColor(0xFAFAFA)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.register(MineLogisticsTablCell.self, forCellReuseIdentifier: MineLogisticsTablCell.identifier)
        view.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        view.estimatedRowHeight = 100
        view.rowHeight = UITableView.automaticDimension
        return view
    }()
    
    lazy var dataArray = ["【东莞市】 快件离开 【虎门中心】 已发往 【成都中转】",
                          "【东莞市】 快件已经到达 【虎门中心】",
                          "【深圳市】 快件离开 【深圳公明】 已发往 【成都中转】",
                          "【深圳市】 【深圳公明】（0755-27688055、0755-27688066） 的 客户马山头38栋 （13800138009） 已揽收"
                          ]
    
    // MARK: - Method
    
    func fetchData() {
        
        guard order_no != "" else {
            ZYToast.showCenterWithText(text: "请输入快递单号")
            return
        }
        HudHelper.showWaittingHUD(msg: "请稍后")
        EZNetworkTool.shared.aliwuliuQuery(order: order_no, completion: { (model) in
            HudHelper.hideHUD()
            self.kuaidiInfo = model
        }) { (msg) in
            HudHelper.hideHUD()
            ZYToast.showCenterWithText(text: msg)
        }
    }
    
    
}

extension MineLogisticsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kuaidiInfo.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MineLogisticsTablCell.identifier, for: indexPath) as! MineLogisticsTablCell
        
        cell.titleLab.text = kuaidiInfo.list[indexPath.row].status
        cell.dateLab.text = kuaidiInfo.list[indexPath.row].time
        
//        if indexPath.row == 0 {
//            cell.isCurrented = true
//            cell.isDownLine = true
//            cell.isCurrented = true
//            cell.isUpCorner = true
//        }else if indexPath.row == dataArray.count - 1 {
//            cell.isCurrented = false
//            cell.isDownCorner = true
//            cell.isUpLine = true
//            cell.isDownLine = false
//        }else{
//            cell.isCurrented = false
//            cell.isUpLine = true
//            cell.isDownLine = true
//        }

        return cell
    }
    
}
