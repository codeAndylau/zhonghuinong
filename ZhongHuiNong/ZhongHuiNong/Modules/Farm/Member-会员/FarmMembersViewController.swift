//
//  FarmMembersViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// 农场会员
class FarmMembersViewController: TableViewController {

    // MARK: - Property
    
    var page = 1

    var dropupView: DropupMenu!
    
    var bannerArray: [String] = [] {
        didSet {
            self.tableView_g.reloadSections([0], with: UITableView.RowAnimation.fade)
        }
    }

    var bannerList: [BannerList] = [] {
        didSet {
            bannerArray.removeAll()
            bannerList.forEach { (item) in
                bannerArray.append(item.bannerPicUrl)
            }
        }
    }
    
    /// 分类列表
    var catagoryList: [CatagoryList] = [] {
        didSet {
            headerView.classView.catagoryList = catagoryList
        }
    }
    
    /// 热销列表
    var hotsaleList: [GoodsInfo] = [] {
        didSet {
            tableView_g.reloadData()
        }
    }
    
    var recommendList: [GoodsInfo] = [] {
        didSet {
            tableView_g.reloadData()
            //self.tableView_g.reloadSections([2], with: UITableView.RowAnimation.fade)
        }
    }
    
    var isValue: Bool = false

    func refreshValue() {
        
        //LoadingView.hideHUD(view: self.view)
        if catagoryList.isEmpty || bannerList.isEmpty || hotsaleList.isEmpty || recommendList.isEmpty {
            return
        }
        
        debugPrints("首页数据---\(bannerList.isEmpty)--\(catagoryList.isEmpty)---\(hotsaleList.isEmpty)---\(recommendList.isEmpty)")
        
        isValue = true

        view.addSubview(tableView_g)
        
        UIView.animate(withDuration: 0.25) {
            self.tableView_g.alpha = 1
        }

        mainQueue {  }
    }

    override func makeUI() {
        super.makeUI()
        
        if User.hasUser() && User.currentUser().isVip != 0 {
            navigationItem.leftBarButtonItem = leftBarItem
        }
        
        navigationItem.rightBarButtonItem = rightMsgItem
        
        
        view.addSubview(tableView_g)
        
        dropupView = DropupMenu(containerView: self.navigationController!.view, contentView: mineCenterView) // 上啦
        
        //LoadingHud.showProgress(supView: self.view)
        //LoadingHud.hideHUD()
        //LoadingView.showView(view: self.view)
        loadAllData()
    }
    
    override func bindViewModel() {
        super.bindViewModel()

        vipItem.sureBtn.rx.tap.subscribe(onNext: { (_) in
            self.showCenterView()
        }).disposed(by: rx.disposeBag)
        
        headerView.searchView.sureBtn.rx.tap.subscribe(onNext: {
            self.navigator.show(segue: Navigator.Scene.searchGoodsInfo, sender: self)
        }).disposed(by: rx.disposeBag)
        
        headerView.cellDidSelectedClosure = { index in
            switch index {
            case 0: self.navigator.show(segue: .delivery, sender: self)     // 配送选货
            case 1: self.navigator.show(segue: .scan, sender: self)         // 扫码溯源
            case 2: self.navigator.show(segue: .privateFarm, sender: self)  // 私家农场
            default:
                break
            }
        }
        
        headerView.classView.cellDidSelectedClosure = { index in
            self.tabBarController?.selectedIndex = 1
            let userInfo = [NSNotification.Name.HomeGoodsClassDid.rawValue : index]
            NotificationCenter.default.post(name: .HomeGoodsClassDid, object: nil, userInfo: userInfo)
        }

    }
    
    // MARK: - Lazy
    
    lazy var vipItem = FarmHeaderView.loadView()
    lazy var mineCenterView = MineCenterView.loadView()
    lazy var dropView = MemberDropdownView.loadView()
    lazy var paySelectDemo = PaySelectViewController()
    lazy var headerView = MemberHeaderView.loadView()
    lazy var leftBarItem = BarButtonItem(customView: vipItem)
    lazy var searchView = MemberSearchView.loadView()
    lazy var rightMsgItem = BarButtonItem(image: UIImage(named: "farm_message"), target: self, action: #selector(messageAction))
    
    lazy var tableView_g: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH-kTabBarH), style: .grouped)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.tableHeaderView = headerView
        view.register(MemberXinpinCell.self, forCellReuseIdentifier: MemberXinpinCell.identifier)       // 新品cell
        view.register(MemberQianggouCell.self, forCellReuseIdentifier: MemberQianggouCell.identifier)   // 抢购cell
        view.register(MemberRexiaoCell.self, forCellReuseIdentifier: MemberRexiaoCell.identifier)       // 热销cell
        view.register(MemberTuijianCell.self, forCellReuseIdentifier: MemberTuijianCell.identifier)     // 推荐cell
        
        /// 解决刷新的时候存在都用的问题
        view.estimatedRowHeight = 0
        view.estimatedSectionFooterHeight = 0
        view.estimatedSectionHeaderHeight = 0
        
        view.uHead = MJDIYHeader(refreshingBlock: {
            self.page = 1
            self.loadAllData()
        })
        
        view.uFoot =  MJDIYAutoFooter(refreshingBlock: {
            self.page += 1
            self.fetchRecommendList(isHeader: false, isFooter: true)
        })

        return view
    }()
    
    // MARK: - Public methods
    
    @objc func messageAction() {
        navigator.show(segue: .mineMessage, sender: self)
        //        let bindVC = MobileBindingViewController()
        //        self.navigationController?.pushViewController(bindVC, animated: true)

    }
    
    func showCenterView() {
        if dropupView.isShown {
            dropupView.hideMenu()
        }else {
            dropupView.showMenu()
        }
    }
    
    
    func loadAllData() {
        fetchBannerList()
        fetchCatagoryList()
        fetchHotsaleList()
        fetchRecommendList()
    }
    
    func fetchBannerList() {
        
        var p = [String: Any]()
        p["wid"] = 1
        
        WebAPITool.requestModelArrayWithData(.homeBannerList(p), model: BannerList.self, complete: { (list) in
            self.tableView_g.uHead.endRefreshing()
            self.bannerList.removeAll()
            self.bannerList = list
        }) { (error) in
            self.tableView_g.uHead.endRefreshing()
        }
    }
    
    func fetchCatagoryList() {
        
        var p = [String: Any]()
        p["wid"] = wid
        WebAPITool.requestModelArrayWithData(WebAPI.catagoryList(p), model: CatagoryList.self, complete: { (list) in
            self.tableView_g.uHead.endRefreshing()
            self.catagoryList.removeAll()
            self.catagoryList = list
        }) { (error) in
            self.tableView_g.uHead.endRefreshing()
        }
    }
    
    /// 热销
    func fetchHotsaleList() {
        
        var p = [String: Any]()
        p["category_id"] = 0
        p["page_size"] = 3
        p["page_index"] = 1
        p["wid"] = wid
        
        WebAPITool.requestModelArrayWithData(WebAPI.goodsHotsaleList(p), model: GoodsInfo.self, complete: { (list) in
            self.tableView_g.uHead.endRefreshing()
            self.hotsaleList.removeAll()
            self.hotsaleList = list
        }) { (error) in
            self.tableView_g.uHead.endRefreshing()
        }

    }
    
    /// 爆款
    func fetchRecommendList(isHeader: Bool = true, isFooter: Bool = false ) {
        
        var p = [String: Any]()
        p["category_id"] = 0
        p["page_size"] = 10
        p["page_index"] = page
        p["wid"] = wid
        
        WebAPITool.requestModelArrayWithData(WebAPI.goodsRecommendList(p), model: GoodsInfo.self, complete: { (list) in

            if isHeader {
                self.tableView_g.uHead.endRefreshing()
                self.recommendList.removeAll()
                self.recommendList = list
            }
            
            if isFooter {
                self.tableView_g.uFoot.endRefreshing()
                self.recommendList += list
                self.recommendList = self.handleFilterArray(arr: self.recommendList)
            }

        }) { (error) in
            if isHeader {
                self.tableView_g.uHead.endRefreshing()
            }
            
            if isFooter {
                self.tableView_g.uFoot.endRefreshing()
            }
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

extension FarmMembersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        case 2:
            return recommendList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MemberXinpinCell.identifier, for: indexPath) as! MemberXinpinCell
            cell.bannerView.bannerArray.accept(bannerArray)
            cell.bannerView.didSelectedClosure = { index in
                let goodId = self.bannerList[index].id
                debugPrints("点击新品上架商品的id---\(goodId)")
                //self.navigator.show(segue: .goodsDetail(id: goodId), sender: self)
            }
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MemberRexiaoCell.identifier, for: indexPath) as! MemberRexiaoCell
            cell.hotsaleList = hotsaleList
            cell.cellDidClosure = { index in
                let goodId = self.hotsaleList[indexPath.row].id
                debugPrints("点击热销商品的id---\(goodId)")
                self.navigator.show(segue: .goodsDetail(id: goodId), sender: self)
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberTuijianCell.identifier, for: indexPath) as! MemberTuijianCell
        cell.imgView.lc_setImage(with: recommendList[indexPath.row].focusImgUrl)
        
        return cell
        
        //        if indexPath.section == 1 {  
        //            let cell = tableView.dequeueReusableCell(withIdentifier: MemberQianggouCell.identifier, for: indexPath) as! MemberQianggouCell
        //            return cell
        //        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            return MemberSectionView(type: .xinpin)
        case 1:
            
            let view = MemberSectionView(type: .rexiao)
            view.moreBtn.rx.tap.subscribe(onNext: {
                self.navigator.show(segue: .hot(list: self.hotsaleList), sender: self)
            }).disposed(by: rx.disposeBag)
            return view
        case 2:
            return MemberSectionView(type: .tuijian)
        default:
            break
        }
        
        let view = MemberSectionView(type: .xinpin)
        return view
        
        //        case 1:
        //            let view = MemberSectionView(type: .qianggou)
        //            view.moreBtn.rx.tap.subscribe(onNext: { [weak self] in
        //                guard let self = self else { return }
        //                debugPrints("点击了倒计时")
        //                self.navigator.show(segue: .flash, sender: self)
        //            }).disposed(by: rx.disposeBag)
        //            return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let goodId = recommendList[indexPath.row].id
        debugPrints("点击推荐商品的id---\(goodId)")
        self.navigator.show(segue: .goodsDetail(id: goodId), sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return kScreenW - 30
        }
        return 200
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    //将分组尾设置为一个空的View
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // 动画效果
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard indexPath.section == 3 else { return }
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        UIView.animate(withDuration: 0.1) {
            cell.transform = CGAffineTransform.identity.scaledBy(x: 0.96, y: 0.96)
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard indexPath.section == 3 else { return }
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        UIView.animate(withDuration: 0.1) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        
//        if offsetY > 0 {
//            navigationController?.navigationBar.layer.shadowColor = UIColor.hexColor(0xA9A9A9).cgColor
//            navigationController?.navigationBar.layer.shadowOpacity = 0.3
//            navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: -1)
//            navigationController?.navigationBar.layer.shadowRadius = 3
//        }
//
//        if offsetY <= 0 {
//            navigationController?.navigationBar.layer.shadowColor = UIColor.white.cgColor
//        }
    }
    
}


// MARK: - 第一版本先隐藏掉
/*
 
 var isShadowColor = false
 
 var menuView: DropdownMenu!
 var dropupView: DropupMenu!
 
 var addItem = Button().then { (btn) in
 btn.setImage(UIImage(named: "farm_add")!, for: .normal)
 }
 addItem.addTarget(self, action: #selector(addAction), for: UIControl.Event.touchUpInside)
 
 menuView = DropdownMenu(containerView: UIApplication.shared.keyWindow!, contentView: dropView) // 下拉
 dropupView = DropupMenu(containerView: self.navigationController!.view, contentView: mineCenterView) // 上啦
 
 dropView.cardView.rx.tap.subscribe(onNext: { (_) in
 self.menuView.hide()
 }).disposed(by: rx.disposeBag)
 
 dropView.scanView.rx.tap.subscribe(onNext: { (_) in
 self.menuView.hide()
 }).disposed(by: rx.disposeBag)
 
 lazy var rightAddItem = BarButtonItem(customView: addItem)
 @objc func addAction() {
 if menuView.isShown {
 menuView.hideMenu()
 }else {
 menuView.showMenu()
 }
 }
 
 func showCenterView() {
 if dropupView.isShown {
 dropupView.hideMenu()
 }else {
 dropupView.showMenu()
 }
 }
 
 func roateArrow() {
 let anim = CABasicAnimation()
 if addItem.isSelected {
 anim.fromValue = Double.pi/4
 anim.toValue = 0
 }else {
 anim.fromValue = 0
 anim.toValue = Double.pi/4
 }
 anim.keyPath = "transform.rotation"
 anim.duration = 0.3
 anim.isRemovedOnCompletion = false //以下两句可以设置动画结束时 layer停在toValue这里
 anim.fillMode = CAMediaTimingFillMode.forwards
 addItem.imageView?.layer.add(anim, forKey: nil)
 //切换按钮的选中状态
 addItem.isSelected = !addItem.isSelected
 
 if addItem.isSelected {
 menuView.showMenu()
 }else {
 menuView.hideMenu()
 let anim = CABasicAnimation()
 anim.fromValue = Double.pi/4
 anim.toValue = 0
 anim.keyPath = "transform.rotation"
 anim.duration = 0.3
 anim.isRemovedOnCompletion = false //以下两句可以设置动画结束时 layer停在toValue这里
 anim.fillMode = CAMediaTimingFillMode.forwards
 addItem.imageView?.layer.add(anim, forKey: nil)
 }
 }
 */
