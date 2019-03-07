//
//  StoreViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import MJRefresh

/// 商店
class StoreViewController: ViewController {
    
    // MARK: Property
    
    var group = DispatchGroup()
    var currentIndexPath = IndexPath(row: 0, section: 0)
    
    var goodsList: [[GoodsInfo]] = []
    
    var catagoryList: [CatagoryList] = [] {
        didSet {
            for item in catagoryList {
                if let id = item.id {
                    fetchGoodsList(category_id: id)
                }
            }
            
            group.notify(queue: .main) {
                
                if self.catagoryList.isEmpty || self.goodsList.isEmpty {
                    debugPrints("请求的集市数据数据-----\(self.catagoryList.isEmpty)---\(self.goodsList.isEmpty)")
                }else {
                    mainQueue {
                        UIView.animate(withDuration: 0.25) {
                            self.leftTableView.alpha = 1
                            self.rightTableView.alpha = 1
                        }
                        self.leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
                        self.view.addSubview(self.leftTableView)
                        self.view.addSubview(self.rightTableView)
                        self.leftTableView.reloadData()
                        self.rightTableView.reloadData()
                    }
                }
            }
            
        }
    }
    
    // MARK: - Override
    
    override func makeUI() {
        super.makeUI()
        navigationItem.titleView = searchView
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightMsgItem
        fetchCatagoryList()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        var isUp = true
        filterView.priceBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            isUp = !isUp
            self.filterView.value = isUp
            self.filterView.priceBtn.setTitleColor(UIColor.hexColor(0x1DD1A8), for: .normal)
            self.filterView.numBtn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
        }).disposed(by: rx.disposeBag)
        
        filterView.numBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.filterView.priceBtn.setImage(UIImage(named: "store_price_normal"), for: .normal)
            self.filterView.priceBtn.setTitleColor(UIColor.hexColor(0x999999), for: .normal)
            self.filterView.numBtn.setTitleColor(UIColor.hexColor(0x1DD1A8), for: .normal)
        }).disposed(by: rx.disposeBag)
        
        
        NotificationCenter.default.rx.notification(Notification.Name.HomeGoodsClassDid).subscribe(onNext: { [weak self] (notification) in
            guard let self = self else { return }
            let value = notification.userInfo?[Notification.Name.HomeGoodsClassDid.rawValue] as! Int
            let indexPath = IndexPath(row: value, section: 0)
            guard value < self.catagoryList.count else { return }
            
            if self.currentIndexPath != indexPath {
                let cell = self.leftTableView.cellForRow(at: self.currentIndexPath) as? StoreLeftCell
                cell?.isShow = false
            }
            
            let cell = self.leftTableView.cellForRow(at: indexPath) as! StoreLeftCell
            cell.isShow = true
            
            self.currentIndexPath = indexPath
            self.leftTableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .middle, animated: true)
            self.rightTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            
        }).disposed(by: rx.disposeBag)
        
    }
    
    // MARK: - Lazy
    // "store_qianggou", , "store_renquan"
    //    lazy var leftArray = ["store_jingpin", "store_shuiguo", "store_danlei", "store_liangyou", "store_rupin", "store_tiaowei", "store_gaodian"]
    
    lazy var searchView = MemberSearchView.loadView()
    lazy var filterView = StoreFilterView.loadView()
    lazy var vipItem = FarmHeaderView.loadView()
    lazy var leftBarItem = BarButtonItem(customView: vipItem)
    lazy var rightMsgItem = BarButtonItem(image: UIImage(named: "farm_message"), target: self, action: #selector(messageAction))
    
    //左侧表格
    lazy var leftTableView : UITableView = {
        let leftTableView = UITableView()
        leftTableView.alpha = 0
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.frame = CGRect(x: 0, y: kNavBarH, width: 88, height: kScreenH-kNavBarH-kTabBarH)
        leftTableView.rowHeight = 55
        leftTableView.showsVerticalScrollIndicator = false
        leftTableView.separatorColor = UIColor.clear
        leftTableView.backgroundColor = UIColor.white
        leftTableView.register(StoreLeftCell.self, forCellReuseIdentifier: StoreLeftCell.identifier)
        return leftTableView
    }()
    
    //右侧表格
    lazy var rightTableView : UITableView = {
        let rightTableView = UITableView()
        rightTableView.alpha = 0
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.frame = CGRect(x: 88, y: kNavBarH, width: UIScreen.main.bounds.width - 88, height: kScreenH-kNavBarH-kTabBarH)
        rightTableView.rowHeight = 80
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.separatorColor = UIColor.clear
        rightTableView.backgroundColor = UIColor.white
        rightTableView.register(StoreRightCell.self, forCellReuseIdentifier: StoreRightCell.identifier)
        rightTableView.uHead = MJDIYHeader(refreshingBlock: {
            if  let id = self.catagoryList[self.currentIndexPath.row].id {
                self.fetchGoodsList(category_id: id, isRefresh: true)
            }
        })
        
        rightTableView.uFoot = MJDIYAutoFooter(refreshingBlock: {
            if  let id = self.catagoryList[self.currentIndexPath.row].id {
                self.fetchGoodsList(category_id: id, isRefresh: true)
            }
        })
        
        return rightTableView
    }()
    
    // MARK: - Action
    
    @objc func messageAction() {
        let config = NoticeBarConfig(title: "点击了消息按钮", barStyle: NoticeBarStyle.onTabbar)
        let noticeBar = NoticeBar(config: config)
        noticeBar.show(duration: 1.5, completed: nil)
    }
    
    /// 获取分类列表
    func fetchCatagoryList() {
        var p = [String: Any]()
        p["wid"] = 5
        WebAPITool.requestModelArray(WebAPI.catagoryList(p), model: CatagoryList.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            self.catagoryList = list
        }) { (error) in
            debugPrints("商品分类列表---\(error)")
        }
    }
    
    /// 分类id,如果为0，则取所有分类的商品数据
    func fetchGoodsList(category_id: Int, isRefresh: Bool = false) {
        var p = [String: Any]()
        p["category_id"] = category_id
        p["keywords"] = ""
        p["page_size"] = 10
        p["page_index"] = 1
        p["wid"] = 5
        debugPrints("分类id---\(category_id)")
        group.enter()
        WebAPITool.requestModelArray(WebAPI.goodsList(p), model: GoodsInfo.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            if isRefresh {
                self.rightTableView.uHead.endRefreshing()
                self.rightTableView.uFoot.endRefreshing()
                var array = self.goodsList[self.currentIndexPath.row]
                list.forEach({ (item) in
                    array.append(item)
                })
                self.goodsList[self.currentIndexPath.row] = array
                mainQueue {
                    self.rightTableView.reloadData()
                }
            }else {
                self.goodsList.append(list)
            }
            self.group.leave()
        }) { (error) in
            self.group.leave()
            debugPrints("商品分类列表---\(error)")
        }
    }
}

// MARK: - UITableViewDataSource
extension StoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leftTableView == tableView {
            return catagoryList.count
        } else {
            return goodsList[currentIndexPath.row].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if leftTableView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: StoreLeftCell.identifier, for: indexPath) as! StoreLeftCell
            cell.isShow = indexPath == currentIndexPath
            cell.titleLab.text = catagoryList[indexPath.row].title
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: StoreRightCell.identifier, for: indexPath) as! StoreRightCell
            cell.model = goodsList[indexPath.row][indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if leftTableView == tableView {
            return 50
        }
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if leftTableView == tableView {
            if currentIndexPath != indexPath {
                let cell = tableView.cellForRow(at: currentIndexPath) as? StoreLeftCell
                cell?.isShow = false
            }
            
            let cell = tableView.cellForRow(at: indexPath) as! StoreLeftCell
            cell.isShow = true
            
            currentIndexPath = indexPath
            leftTableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .middle, animated: true)
            rightTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            rightTableView.reloadData()
        }
        
        if rightTableView == tableView {
            let goodId = goodsList[indexPath.row][indexPath.row].id
            debugPrints("点击对应的商品id----\(goodId)")
            self.navigator.show(segue: .goodsDetail(id: goodId), sender: self)
        }
    }
}
