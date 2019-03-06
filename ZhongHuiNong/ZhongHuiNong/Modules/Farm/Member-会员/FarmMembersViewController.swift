//
//  FarmMembersViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 农场会员
class FarmMembersViewController: TableViewController {

    // MARK: - Property
    var isShadowColor = false
    var menuView: DropdownMenu!
    var dropupView: DropupMenu!
    
    var addItem = UIButton().then { (btn) in
        btn.setImage(UIImage(named: "farm_add")!, for: .normal)
    }

    var bannerList: [BannerList] = [] {
        didSet {
           refreshValue()
        }
    }
    
    var catagoryList: [CatagoryList] = [] {
        didSet {
           refreshValue()
        }
    }
    
    var isValue: Bool = false

    func refreshValue() {
        if bannerList.isEmpty || catagoryList.isEmpty {
            isValue = true
            tableView_g.uempty?.allowShow = true
            return
        }
        debugPrints("首页数据---\(bannerList.isEmpty)--\(catagoryList.isEmpty)")
        UIView.animate(withDuration: 0.25) {
            self.tableView_g.alpha = 1
        }
        tableView_g.tableHeaderView = headerView
        tableView_g.reloadData()
    }

    override func makeUI() {
        super.makeUI()
        
        if User.hasUser() && User.currentUser().isVip {
            navigationItem.leftBarButtonItem = leftBarItem
        }
        
        navigationItem.rightBarButtonItems = [rightMsgItem,rightAddItem]
        addItem.addTarget(self, action: #selector(addAction), for: UIControl.Event.touchUpInside)
        
        tableView_g.alpha = 0
        tableView_g.dataSource = self
        tableView_g.delegate = self
        tableView_g.register(MemberXinpinCell.self, forCellReuseIdentifier: MemberXinpinCell.identifier)       // 新品cell
        tableView_g.register(MemberQianggouCell.self, forCellReuseIdentifier: MemberQianggouCell.identifier)   // 抢购cell
        tableView_g.register(MemberRexiaoCell.self, forCellReuseIdentifier: MemberRexiaoCell.identifier)       // 热销cell
        tableView_g.register(MemberTuijianCell.self, forCellReuseIdentifier: MemberTuijianCell.identifier)     // 推荐cell
        tableView_g.uempty = UEmptyView(verticalOffset: -kNavBarH, tapClosure: nil)
    }
    
    override func bindViewModel() {
        super.bindViewModel()

        menuView = DropdownMenu(containerView: UIApplication.shared.keyWindow!, contentView: dropView) // 下拉
        dropupView = DropupMenu(containerView: self.navigationController!.view, contentView: mineCenterView) // 上啦
        
        dropView.cardView.rx.tap.subscribe(onNext: { (_) in
            self.menuView.hide()
        }).disposed(by: rx.disposeBag)
        
        dropView.scanView.rx.tap.subscribe(onNext: { (_) in
            self.menuView.hide()
        }).disposed(by: rx.disposeBag)
        
        vipItem.sureBtn.rx.tap.subscribe(onNext: { (_) in
            self.showCenterView()
        }).disposed(by: rx.disposeBag)
        
        headerView.searchView.sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            let search = SearchViewController()
            self?.navigationController?.pushViewController(search, animated: true)
        }).disposed(by: rx.disposeBag)
        
        headerView.cellDidSelectedClosure = {  [weak self] index in
            guard let self = self else { return }
            switch index {
            case 0: self.navigator.show(segue: .delivery, sender: self)     // 配送选货
            case 1: self.navigator.show(segue: .scan, sender: self)         // 扫码溯源
            case 2: self.navigator.show(segue: .privateFarm, sender: self)  // 私家农场
            default:
                break
            }
        }
        
        headerView.classView.cellDidSelectedClosure = {  [weak self] index in
            guard let self = self else { return }
            self.tabBarController?.selectedIndex = 1
            let userInfo = [NSNotification.Name.HomeGoodsClassDid.rawValue : index]
            NotificationCenter.default.post(name: .HomeGoodsClassDid, object: nil, userInfo: userInfo)
        }
        
        fetchBannerList()
        fetchCatagoryList()
    }
    
    // MARK: - Lazy
    lazy var dataArray = ["goods_tuijian_1","goods_tuijian_2","goods_tuijian_3","goods_tuijian_4","goods_tuijian_5","goods_tuijian_6"]
    
    lazy var vipItem = FarmHeaderView.loadView()
    lazy var mineCenterView = MineCenterView.loadView()
    lazy var dropView = MemberDropdownView.loadView()
    lazy var paySelectDemo = PaySelectViewController()
    lazy var headerView = MemberHeaderView.loadView()
    lazy var leftBarItem = BarButtonItem(customView: vipItem)
    lazy var rightAddItem = BarButtonItem(customView: addItem)
    lazy var rightMsgItem = BarButtonItem(image: UIImage(named: "farm_message"), target: self, action: #selector(messageAction))
    lazy var searchView = MemberSearchView().then { (view) in
        view.frame = CGRect(x: 0, y: 0, width: kScreenW-150, height: 34)
    }
    
    // MARK: - Public methods
    @objc func addAction() {
        if menuView.isShown {
            menuView.hideMenu()
        }else {
            menuView.showMenu()
        }
    }
    
    @objc func messageAction() {
        debugPrints("点击了消息按钮")
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
    
    func loadData(more: Bool = false) {
        tableView_g.uempty?.allowShow = true
    }
    
    func fetchBannerList() {
        
        var p = [String: Any]()
        p["wid"] = 5
        
        WebAPITool.requestModelArray(.homeBannerList(p), model: BannerList.self, complete: { [weak self] (list) in
            debugPrints("轮播图---\(list)")
            guard let self = self else { return }
            self.bannerList = list
        }) { (error) in
            debugPrints("获取轮播图失败---\(error)")
        }
    }
    
    func fetchCatagoryList() {
        var p = [String: Any]()
        p["wid"] = 5
        WebAPITool.requestModelArray(WebAPI.catagoryList(p), model: CatagoryList.self, complete: { [weak self] (list) in
            debugPrints("分类列表---\(list)")
            guard let self = self else { return }
            self.catagoryList = list
        }) { (error) in
            debugPrints("获取轮播图失败---\(error)")
        }
    }

}

extension FarmMembersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isValue ? 4 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2:
            return 1
        case 3:
            return dataArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MemberXinpinCell.identifier, for: indexPath) as! MemberXinpinCell
            cell.bannerView.bannerArray.accept(bannerList)
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MemberQianggouCell.identifier, for: indexPath) as! MemberQianggouCell
            return cell
        }
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MemberRexiaoCell.identifier, for: indexPath) as! MemberRexiaoCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberTuijianCell.identifier, for: indexPath) as! MemberTuijianCell
        cell.imgView.image = UIImage(named: dataArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            return MemberSectionView(type: .xinpin)
        case 1:
            let view = MemberSectionView(type: .qianggou)
            view.moreBtn.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                debugPrints("点击了倒计时")
                self.navigator.show(segue: .flash, sender: self)
            }).disposed(by: rx.disposeBag)
            return view
        case 2:
            
            let view = MemberSectionView(type: .rexiao)
            view.moreBtn.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                debugPrints("点击了查看更多")
                self.navigator.show(segue: .hot, sender: self)
            }).disposed(by: rx.disposeBag)
            return view
        case 3:
            return MemberSectionView(type: .tuijian)
        default:
            break
        }
        
        let view = MemberSectionView(type: .xinpin)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigator.show(segue: .goodsDetail, sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
