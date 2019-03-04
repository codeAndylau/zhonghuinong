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
    
    override func makeUI() {
        super.makeUI()
        
        navigationItem.titleView = searchView
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightMsgItem
        
        view.addSubview(leftTableView)
        view.addSubview(rightTableView)
        view.addSubview(filterView)
        
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
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
            
            let value = notification.userInfo?[Notification.Name.HomeGoodsClassDid.rawValue] as! Int
            
            let indexPath = IndexPath(row: value, section: 0)
            
            if self.currentIndexPath != indexPath {
                let cell = self.leftTableView.cellForRow(at: self.currentIndexPath) as? StoreLeftCell
                cell?.ImgView.image = UIImage(named: self.leftArray[self.currentIndexPath.row])
            }
            
            let cell = self.leftTableView.cellForRow(at: indexPath) as? StoreLeftCell
            cell?.ImgView.image = UIImage(named: self.leftArray[indexPath.row]+"_h")
            
            self.currentIndexPath = indexPath
            self.leftTableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .middle, animated: true)
            self.rightTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            
        }).disposed(by: rx.disposeBag)
        
    }
    
    // MARK: - Lazy // "store_qianggou", , "store_renquan"
    lazy var leftArray = ["store_jingpin", "store_shuiguo", "store_danlei", "store_liangyou", "store_rupin", "store_tiaowei", "store_gaodian"]
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
}

extension StoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leftTableView == tableView {
            return leftArray.count
        } else {
            return 8
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if leftTableView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: StoreLeftCell.identifier, for: indexPath) as! StoreLeftCell
            cell.ImgView.image = indexPath == currentIndexPath ? UIImage(named: leftArray[indexPath.row]+"_h") : UIImage(named: leftArray[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: StoreRightCell.identifier, for: indexPath) as! StoreRightCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if leftTableView == tableView {
            return 88
        }
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if leftTableView == tableView {
            if currentIndexPath != indexPath {
                let cell = tableView.cellForRow(at: currentIndexPath) as? StoreLeftCell
                cell?.ImgView.image = UIImage(named: leftArray[currentIndexPath.row])
            }
            let cell = tableView.cellForRow(at: indexPath) as! StoreLeftCell
            cell.ImgView.image = UIImage(named: leftArray[indexPath.row]+"_h")
            currentIndexPath = indexPath
            leftTableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .middle, animated: true)
            rightTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        
        if rightTableView == tableView {
            self.navigator.show(segue: .goodsDetail, sender: self)
        }
    }
}
