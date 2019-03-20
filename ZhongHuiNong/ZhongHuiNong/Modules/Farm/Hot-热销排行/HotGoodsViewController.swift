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
    
    var isData = true
    
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
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH), style: .grouped)
        view.backgroundColor = UIColor.white
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.register(HotTabCell.self, forCellReuseIdentifier: HotTabCell.identifier)
        view.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0)
        
        view.uHead = MJDIYHeader(refreshingBlock: {
            self.page = 1
            self.isData = true
            self.tableView.uFoot.isHidden = false
            self.tableView.uFoot.resetNoMoreData()
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

            if self.page > 1 {
                
                if list.count == 0 {
                    self.isData = false
                    self.tableView.uFoot.endRefreshingWithNoMoreData()
                    self.tableView.uFoot.isHidden = true
                    self.tableView.reloadData()
                }else {
                    self.hotsaleList += list
                    self.hotsaleList = self.handleFilterArray(arr: self.hotsaleList)
                    if self.hotsaleList.count == self.handleFilterArray(arr: self.hotsaleList).count {
                        self.isData = false
                        self.tableView.uFoot.endRefreshingWithNoMoreData()
                        self.tableView.uFoot.isHidden = true
                        self.tableView.reloadData()
                    }
                }
            }else {
                self.hotsaleList.removeAll()
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
    
    /// 过滤掉重复的元素
    func handleFilterArray(arr:[GoodsInfo]) -> [GoodsInfo] {
        var temp = [GoodsInfo]()
        var nameArray = [String]()
        for model in arr {
            let name = model.productName
            if !nameArray.contains(name){
                nameArray.append(name)
                temp.append(model)
            }
        }
        return temp    //最终返回的数组中已经筛选掉重复name的model
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
        self.navigator.show(segue: .goodsDetail(id: goodsId), sender: topVC)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if isData == false {
            return 50
        }
        return  0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if isData == false {
            let view = NoMoreFooterView.loadView()
            view.titleLab.text = "没有更多了~"
            return view
        }
        return UIView()
    }
    
}
