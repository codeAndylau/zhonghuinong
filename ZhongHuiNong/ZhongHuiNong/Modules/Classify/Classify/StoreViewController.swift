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
    
    var dropupView: DropupMenu!
    
    /// 默认请求的第一个数据
    var currentIndexPath = IndexPath(row: 0, section: 0)
    
    var classInfos: [StoreModel] = [] {
        
        willSet {
            // 等于0
            guard newValue[currentIndexPath.row].goodsInfo.count != 0 else {
                EmptyStore.goodsInfoEmpty(onView: self.view)
                return
            }
            
            EmptyStore.removeEmpty(onView: self.view)
        }
        
        didSet {
            rightTableView.reloadData()
        }
    }
    
    var catagoryList: [CatagoryList] = [] {
        didSet {

            // 等于0
            guard catagoryList.count != 0 else {
                EmptyStore.loadEmpty(onView: self.view, block: {
                    self.fetchCatagoryList()
                })
                return
            }
            
            EmptyStore.removeEmpty(onView: self.view)
            
            // 1. 获取所有的分离
            for item in catagoryList {
                let model = StoreModel(page: 1, goodsId: item.id, index: 0, end: true)
                classInfos.append(model)
            }
            
            fadeInOnDisplay {
                self.leftTableView.alpha = 1
                self.rightTableView.alpha = 1
            }
            
            view.addSubview(leftTableView)
            view.addSubview(rightTableView)
            
            leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
            
            /// 只会获取第一个分类的数据，后面点击过后再获取
            fetchGoodsInfos(category_id: classInfos[currentIndexPath.row].goodsId, isHeader: true, isFooter: false)
        }
    }
    
    // MARK: - Override
    
    override func makeUI() {
        super.makeUI()

        navigationItem.titleView = searchView
        
        if User.hasUser() && User.currentUser().isVip != 0 {
            vipItem.header.lc_setImage(with: User.currentUser().headimgUrl)
            navigationItem.leftBarButtonItem = leftBarItem
        }
        
        /// 上架的时候隐藏
        if User.hasUser() && User.currentUser().mobile != developmentMan {
            navigationItem.rightBarButtonItem = rightMsgItem
        }
        
        fetchCatagoryList()
        
        view.addSubview(activityView)
        activityView.center = view.center
        activityView.startAnimating()
        
        dropupView = DropupMenu(containerView: self.navigationController!.view, contentView: mineCenterView) // 上啦
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        vipItem.sureBtn.rx.tap.subscribe(onNext: { (_) in
            self.showCenterView()
        }).disposed(by: rx.disposeBag)
        
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

            // 0: 先复制
            self.classInfos[self.currentIndexPath.row].index = indexPath.row

            // 1: 先刷新数据
            self.rightTableView.reloadData()

            // 2: 判断是否数据价值完成
            if self.classInfos[self.currentIndexPath.row].end == true {
                self.rightTableView.tableFooterView = nil
            }else {
                self.rightTableView.uFoot.endRefreshingWithNoMoreData()
                self.rightTableView.uFoot.isHidden = true
                self.rightTableView.tableFooterView = self.footerView
            }
            
            if self.classInfos[indexPath.row].goodsInfo.count == 0 {
                self.fetchGoodsInfos(category_id: self.classInfos[indexPath.row].goodsId, isHeader: true, isFooter: false, index: indexPath.row)
            }

            // FIXME: 没有数据的时候 会造成崩溃
            //self.rightTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            
        }).disposed(by: rx.disposeBag)
        
        searchView.sureBtn.rx.tap.subscribe(onNext: {
            self.navigator.show(segue: Navigator.Scene.searchGoodsInfo, sender: self)
        }).disposed(by: rx.disposeBag)
        
    }
    
    // MARK: - Lazy
    
    lazy var activityView = UIActivityIndicatorView(style: .gray)
    lazy var mineCenterView = MineCenterView.loadView()
    lazy var searchView = MemberSearchView.loadView()
    lazy var filterView = StoreFilterView.loadView()
    lazy var vipItem = FarmHeaderView.loadView()
    lazy var leftBarItem = BarButtonItem(customView: vipItem)
    lazy var rightMsgItem = BarButtonItem(image: UIImage(named: "farm_message"), target: self, action: #selector(messageAction))
    
    lazy var footerView: NoMoreFooterView = {
        let footer = NoMoreFooterView.loadView()
        footer.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 50)
        footer.titleLab.text = "没有更多了~"
        return footer
    }()
    
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
        
        let rightTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        rightTableView.frame = CGRect(x: 88, y: kNavBarH, width: UIScreen.main.bounds.width - 88, height: kScreenH-kNavBarH-kTabBarH)
        rightTableView.alpha = 0
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.rowHeight = 80
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.separatorColor = UIColor.clear
        rightTableView.backgroundColor = UIColor.white
        rightTableView.register(StoreRightCell.self, forCellReuseIdentifier: StoreRightCell.identifier)
        
        /// 解决刷新的时候存在都用的问题
        rightTableView.estimatedRowHeight = 0
        rightTableView.estimatedSectionFooterHeight = 0
        rightTableView.estimatedSectionHeaderHeight = 0
        
        rightTableView.uHead = MJDIYHeader(refreshingBlock: {
            
            /// 重置上啦刷新
            self.classInfos[self.currentIndexPath.row].end = true
            self.rightTableView.tableFooterView = nil
            self.rightTableView.uFoot.isHidden = false
            self.rightTableView.uFoot.resetNoMoreData()
            
            self.classInfos[self.currentIndexPath.row].page = 1
            self.fetchGoodsInfos(category_id: self.classInfos[self.currentIndexPath.row].goodsId, isHeader: true, isFooter: false, index: self.currentIndexPath.row)
        })

        rightTableView.uFoot = MJDIYAutoFooter(refreshingBlock: {
            
            self.classInfos[self.currentIndexPath.row].page += 1
            
            if self.classInfos[self.currentIndexPath.row].end {
                self.fetchGoodsInfos(category_id: self.classInfos[self.currentIndexPath.row].goodsId, isHeader: false, isFooter: true, index: self.currentIndexPath.row)
            }
        })
        
        return rightTableView
    }()
    
    // MARK: - Action
    func showCenterView() {
        if dropupView.isShown {
            dropupView.hideMenu()
        }else {
            dropupView.showMenu()
        }
    }
    
    @objc func messageAction() {
        navigator.show(segue: .mineMessage, sender: self)
    }
    
    /// 获取分类列表
    func fetchCatagoryList() {
        
        var p = [String: Any]()
        p["wid"] = wid
        WebAPITool.requestModelArrayWithData(WebAPI.catagoryList(p), model: CatagoryList.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            self.catagoryList = list
        }) { (error) in
            self.catagoryList = []
            self.activityView.stopAnimating()
        }
    }
    
    func fetchGoodsInfos(category_id: Int, isHeader: Bool = true, isFooter: Bool = false, index: Int = 0) {
        
        var p = [String: Any]()
        p["keywords"] = ""
        p["category_id"] = category_id
        p["page_size"] = 10
        p["page_index"] = classInfos[currentIndexPath.row].page
        p["wid"] = wid
        
        debugPrints("请求的分页数---\(p)")
        
        WebAPITool.requestModelArrayWithData(WebAPI.goodsList(p), model: GoodsInfo.self, complete: { (list) in

            if isHeader {
                
                self.rightTableView.uHead.endRefreshing()
                self.classInfos[self.currentIndexPath.row].goodsInfo.removeAll()
                
                if index == self.classInfos[self.currentIndexPath.row].index {
                    self.classInfos[self.currentIndexPath.row].goodsInfo = list
                }

                if list.count < 10 {
                    self.classInfos[self.currentIndexPath.row].end = false
                    self.rightTableView.uFoot.endRefreshingWithNoMoreData()
                    self.rightTableView.uFoot.isHidden = true
                    self.rightTableView.tableFooterView = self.footerView
                }
            }
            
            if isFooter {
                
                if list.count < 10 {
                    
                    self.classInfos[self.currentIndexPath.row].end = false
                    
                    self.rightTableView.uFoot.endRefreshingWithNoMoreData()
                    self.rightTableView.uFoot.isHidden = true
                    
                    self.rightTableView.tableFooterView = self.footerView
                    self.rightTableView.reloadData()
                }
                
                self.rightTableView.uFoot.endRefreshing()
                
                /// 避免数据混乱的现象
                if index == self.classInfos[self.currentIndexPath.row].index {
                    
                    var tempList = self.classInfos[self.currentIndexPath.row].goodsInfo
                    tempList += list
                    
                    debugPrints("之前总个数---\(tempList.count)---\(self.handleFilterArray(arr: tempList).count)")
                    self.classInfos[self.currentIndexPath.row].goodsInfo = self.handleFilterArray(arr: tempList)
                }
            }
            
        }) { (error) in
            
            self.classInfos[self.currentIndexPath.row].goodsInfo = []
            
            if isHeader {
                self.rightTableView.uHead.endRefreshing()
            }
            
            if isFooter {
                self.rightTableView.uFoot.endRefreshing()
            }
        }
    }
    
    /// 过滤掉重复的元素
    func handleFilterArray(arr:[GoodsInfo]) -> [GoodsInfo] {
        var temp = [GoodsInfo]()  //存放符合条件的model
        var nameArray = [String]()   //存放符合条件model的name，用来判断是否重复
        for model in arr {
            let name = model.productName   //遍历获得model的唯一标识aID
            if !nameArray.contains(name){    //如果该name已经添加过，则不再添加
                nameArray.append(name)
                temp.append(model)    //如果该name没有添加过，则添加到temp数组中
            }
        }
        return temp    //最终返回的数组中已经筛选掉重复name的model
    }

}

// MARK: - UITableViewDataSource
extension StoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leftTableView == tableView {
            return catagoryList.count
        } else {
            return classInfos[currentIndexPath.row].goodsInfo.count
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
            if classInfos[currentIndexPath.row].goodsInfo.count > 0 {
                cell.model = classInfos[currentIndexPath.row].goodsInfo[indexPath.row]
            }
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
                self.rightTableView.uFoot.isHidden = false
                self.rightTableView.uFoot.resetNoMoreData()
                let cell = tableView.cellForRow(at: currentIndexPath) as? StoreLeftCell
                cell?.isShow = false
            }
            
            let cell = tableView.cellForRow(at: indexPath) as! StoreLeftCell
            cell.isShow = true

            currentIndexPath = indexPath
            leftTableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .middle, animated: true)
            
            debugPrint("点击的分类id---\(classInfos[indexPath.row].goodsId)--- \(currentIndexPath.row)")
            
            // 0: 先复制
            self.classInfos[self.currentIndexPath.row].index = indexPath.row
            
            // 1: 先刷新数据
            rightTableView.reloadData()
            
            // 2: 判断是否数据价值完成
            if classInfos[self.currentIndexPath.row].end == true {
                rightTableView.tableFooterView = nil
            }else {
                rightTableView.uFoot.endRefreshingWithNoMoreData()
                rightTableView.uFoot.isHidden = true
                rightTableView.tableFooterView = footerView
            }
            
            // 3: 如果还没有请求数据择先去请求
            if classInfos[indexPath.row].goodsInfo.count == 0 {
                fetchGoodsInfos(category_id: classInfos[indexPath.row].goodsId, isHeader: true, isFooter: false, index: indexPath.row)
            }

            // FIXME: 没有数据的时候 会造成崩溃
            //rightTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            
        }
        
        if rightTableView == tableView {
            let goodsId = classInfos[currentIndexPath.row].goodsInfo[indexPath.row].id
            debugPrints("点击对应的商品id----\(goodsId)")
            self.navigator.show(segue: .goodsDetail(id: goodsId), sender: self)
        }
        
    }
    
}

