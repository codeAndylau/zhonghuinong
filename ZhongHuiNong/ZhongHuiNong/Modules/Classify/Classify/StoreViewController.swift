//
//  StoreViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 商店
class StoreViewController: ViewController {

    var currentIndexPath = IndexPath(row: 0, section: 0)
    var isUp = true
    var isValue: Bool = false
    
    let group = DispatchGroup()
    
    var catagoryList: [CatagoryList] = [] {
        didSet {
            for item in catagoryList {
                if let id = item.id {
                    fetchGoodsList(category_id: id)
                }
            }
            group.notify(queue: .main) {
                debugPrints("请求的说有数据---\(self.goodsList.count)")
                if self.catagoryList.isEmpty || self.goodsList.isEmpty {
                    self.isValue = true
                    self.leftTableView.uempty?.allowShow = true
                    return
                }
                debugPrints("集市数据-----\(self.catagoryList.isEmpty)---\(self.goodsList.isEmpty)")
                mainQueue {
                    self.view.addSubview(self.leftTableView)
                    self.view.addSubview(self.rightTableView)
                    self.leftTableView.reloadData()
                    self.rightTableView.reloadData()
                }
            }
        }
    }
    
    var goodsList: [[GoodsInfo]] = [] {
        didSet {
            //refreshValue()
        }
    }
    
    func refreshValue() {
//        if catagoryList.isEmpty {
//            isValue = true
//            leftTableView.uempty?.allowShow = true
//            return
//        }
//        debugPrints("集市数据-----\(catagoryList.isEmpty)")
//        mainQueue {
//            self.leftTableView.reloadData()
//            self.rightTableView.reloadData()
//        }
    }
    
    override func makeUI() {
        super.makeUI()
        
        navigationItem.titleView = searchView
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightMsgItem
        
        //view.addSubview(filterView)
        fetchCatagoryList()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        filterView.priceBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.isUp = !self.isUp
            self.filterView.value = self.isUp
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
            
//            let value = notification.userInfo?[Notification.Name.HomeGoodsClassDid.rawValue] as! Int
//            
//            let indexPath = IndexPath(row: value, section: 0)
//            
//            if self.currentIndexPath != indexPath {
//                let cell = self.leftTableView.cellForRow(at: self.currentIndexPath) as? StoreLeftCell
//                cell?.ImgView.image = UIImage(named: self.leftArray[self.currentIndexPath.row])
//            }
//            
//            let cell = self.leftTableView.cellForRow(at: indexPath) as? StoreLeftCell
//            cell?.ImgView.image = UIImage(named: self.leftArray[indexPath.row]+"_h")
//            
//            self.currentIndexPath = indexPath
//            self.leftTableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .middle, animated: true)
//            self.rightTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            
        }).disposed(by: rx.disposeBag)
        
    }
    
    // MARK: - Lazy // "store_qianggou", , "store_renquan"
//    lazy var leftArray = ["store_jingpin", "store_shuiguo", "store_danlei", "store_liangyou", "store_rupin", "store_tiaowei", "store_gaodian"]
    
    lazy var searchView = MemberSearchView.loadView()
    lazy var filterView = StoreFilterView.loadView()
    lazy var vipItem = FarmHeaderView.loadView()
    lazy var leftBarItem = BarButtonItem(customView: vipItem)
    lazy var rightMsgItem = BarButtonItem(image: UIImage(named: "farm_message"), target: self, action: #selector(messageAction))
    
    //左侧表格
    lazy var leftTableView : UITableView = {
        let leftTableView = UITableView()
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.frame = CGRect(x: 0, y: kNavBarH + 10, width: 88, height: kScreenH-kNavBarH-kTabBarH-10)
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
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.frame = CGRect(x: 88, y: kNavBarH+44, width: UIScreen.main.bounds.width - 88, height: kScreenH-kNavBarH-kTabBarH-44)
        rightTableView.rowHeight = 80
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.separatorColor = UIColor.clear
        rightTableView.backgroundColor = UIColor.white
        rightTableView.register(StoreRightCell.self, forCellReuseIdentifier: StoreRightCell.identifier)
        return rightTableView
    }()

    
    @objc func messageAction() {
        debugPrints("点击了消息按钮")
        //        let noticeBar = NoticeBar(title: "点击了消息按钮", defaultType: NoticeBarDefaultType.info)
        //        noticeBar.show(duration: 1.5, completed: nil)
        
        let config = NoticeBarConfig(title: "点击了消息按钮", barStyle: NoticeBarStyle.onTabbar)
        let noticeBar = NoticeBar(config: config)
        noticeBar.show(duration: 1.5, completed: nil)
    }
    
    func fetchCatagoryList() {
        var p = [String: Any]()
        p["wid"] = 5
        WebAPITool.requestModelArray(WebAPI.catagoryList(p), model: CatagoryList.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            self.catagoryList = list
        }) { (error) in
            debugPrints("获取轮播图失败---\(error)")
        }
    }
    
    // 分类id,如果为0，则取所有分类的商品数据
    func fetchGoodsList(category_id: Int) {
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
            self.goodsList.append(list)
            self.group.leave()
        }) { (error) in
            self.group.leave()
            self.leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
            debugPrints("获取轮播图失败---\(error)")
        }
    }
}

extension StoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leftTableView == tableView {
            return catagoryList.count
        } else {
            debugPrints("分组-\(section)---\(goodsList[currentIndexPath.row].count)")
            return goodsList[currentIndexPath.row].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if leftTableView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: StoreLeftCell.identifier, for: indexPath) as! StoreLeftCell
            cell.lineView.isHidden = !(indexPath == currentIndexPath)
            debugPrints("分类名----\(String(describing: catagoryList[indexPath.row].title))")
            cell.titleLab.text = catagoryList[indexPath.row].title
            return cell
        } else {
            debugPrints("右边---\(indexPath.section)---\(indexPath.row)")
            let cell = tableView.dequeueReusableCell(withIdentifier: StoreRightCell.identifier, for: indexPath) as! StoreRightCell
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
                cell?.lineView.isHidden = true
                cell?.titleLab.textColor = UIColor.hexColor(0x666666)
            }
            
            let cell = tableView.cellForRow(at: indexPath) as! StoreLeftCell
            cell.lineView.isHidden = false
            cell.titleLab.textColor = Color.theme1DD1A8
            
            currentIndexPath = indexPath
            leftTableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .middle, animated: true)
            rightTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            rightTableView.reloadData()
        }
        
        if rightTableView == tableView {
            self.navigator.show(segue: .goodsDetail, sender: self)
        }
    }
}
