//
//  HotGoodsViewController.swift
//  ZhongHuiNong
//
//  Created by lau Andy on 2019/3/12.
//  Copyright © 2019年 Andylau. All rights reserved.
//

import UIKit

/// 热销排行
class HotGoodsViewController: ViewController {

    var page = 1
    
    var hotsaleList: [GoodsInfo] = []
    
    override func makeUI() {
        super.makeUI()
        
        statusBarStyle.accept(true)
        
        navigationItem.titleView = titleView
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor = UIColor.white
        
        view.backgroundColor = Color.whiteColor
        view.addSubview(topView)
        view.addSubview(tableView)
        
        fetchHotsaleList(true)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lazy
    
    lazy var titleView = UIImageView(image: UIImage(named: "farm_hot_icon"))
    
    lazy var topView = HotView.loadView()

    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH), style: .plain)
        view.backgroundColor = UIColor.white
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.register(HotTabCell.self, forCellReuseIdentifier: HotTabCell.identifier)
        view.uHead = MJDIYHeader(refreshingBlock: {
            self.page = 1
            self.fetchHotsaleList(true)
        })
        
        view.uFoot =  MJDIYAutoFooter(refreshingBlock: {
            self.page += 1
            self.fetchHotsaleList(false)
        })
        return view
    }()
    
    // MARK: - Methods
    
    ///热销
    func fetchHotsaleList(_ isRefresh: Bool = false) {
        
        var p = [String: Any]()
        p["category_id"] = 0
        p["page_size"] = 10
        p["page_index"] = page
        p["wid"] = wid
        
        WebAPITool.requestModelArrayWithData(WebAPI.goodsHotsaleList(p), model: GoodsInfo.self, complete: { (list) in
            debugPrints("获取热销列表---\(list.count)")
            self.tableView.uHead.endRefreshing()
            self.tableView.uFoot.endRefreshing()
            
            if isRefresh {
                self.hotsaleList.removeAll()
            }
            
            if self.page > 1 {
                self.hotsaleList += list
            }else {
                self.hotsaleList = list
            }
            
            mainQueue {
                self.tableView.reloadData()
            }
            
        }) { (error) in
            self.tableView.uHead.endRefreshing()
            self.tableView.uFoot.endRefreshing()
            debugPrints("获取热销列表失败---\(error)")
        }
        
    }
}

extension HotGoodsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotsaleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HotTabCell.identifier, for: indexPath) as! HotTabCell
        cell.goodsInfo = hotsaleList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let goodsId = hotsaleList[indexPath.row].id
        
        debugPrints("点击热销排行商品的id--\(goodsId)")
        
        self.navigator.show(segue: .goodsDetail(id: goodsId), sender: topVC)
    }
    
}
