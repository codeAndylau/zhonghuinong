//
//  DeliveryViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import MBProgressHUD
import PPBadgeViewSwift

/// 配送选货
class DeliveryViewController: ViewController {
    
    // MARK: Preparty
    
    var goodsWeight: CGFloat = 0  // 商品总重量
    var deliverynum: Int = 1      // 配送需要减去的次数
    var scheduleday: Int = 0      // 配送的日期： 星期一
    
    var addressList: [UserAddressInfo] = [] {
        didSet {
            
            if addressList.count > 0 {
                
                let defaultAddressInfo = addressList.filter { (item) -> Bool in
                    if item.isDefault {
                        return true
                    }
                    return false
                }
                
                // 获取默认地址
                if defaultAddressInfo.count >= 1 {
                    headerView.addressView.addressInfo = defaultAddressInfo[0]
                }else {
                    headerView.addressView.addressInfo = addressList[0]
                }
                
            }
        }
    }
    
    /// 获取配送的日期
    var dispatchDate: DispatchDateInfo = DispatchDateInfo() {
        didSet {
            
            /// 1. 没有选择过
            if dispatchDate.monday == false && dispatchDate.tuesday == false && dispatchDate.wednesday == false &&
                dispatchDate.thursday == false && dispatchDate.friday == false && dispatchDate.saturday == false &&
                dispatchDate.sunday == false {
                mainQueue {
                    self.dateViewDemo.show()
                }
            }else {
                
                headerView.dateView.dispatchDate = dispatchDate
                
                // true true false false false false fllse true
                // 1 2 7
                debugPrints("是否可以选择菜--\(selectMenu())")
                
                /// 2. 判断当前能否有阔以选择的蔬菜日期
                /// 3. 再去判断当前是否已经选择过了配送的蔬菜
                if selectMenu() {
                    fetchDispatchOrderList()
                }else {

                    /// 请求是否有已经选择过了配送的订单
                    let emptyV = EmptyView()
                    view.addSubview(emptyV)
                    emptyV.config = EmptyViewConfig(title: "根据你选择的蔬菜配送日期，只能提前两天选菜,今天不在选菜的日程表里无法进行选菜🥬",
                                                    image: UIImage(named: "farm_delivery_nonmember"),
                                                    btnTitle: "确定")
                    emptyV.snp.makeConstraints { (make) in
                        make.top.equalTo(kNavBarH+155)
                        make.left.bottom.right.equalTo(self.view)
                    }

                    emptyV.sureBtnClosure = {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    /// 所有用户可以选择的菜品
    var dispatchMenuInfo: [DispatchMenuInfo] = [] {
        didSet {
            debugPrints("所以阔以选择的菜单列表有\(dispatchMenuInfo.count)个")
        }
    }
    
    /// 判断当前用户是否已经选择过蔬菜了
    var vegetablesInfo: [DispatchVegetablesInfo] = [] {
        
        didSet {
            
            if vegetablesInfo.count > 0 {
                
                //字符串 -> 日期
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                formatter.locale = Locale.init(identifier: "zh_CN")

                /// 判断今天是否已经选择过了
                var isTodaySelected = false
                for item in vegetablesInfo {
                    
                    let dateString = item.createdat.replacingOccurrences(of: "T", with: " ").components(separatedBy: " ")[0]
                    let today = formatter.string(from: Date())
                    
                    if dateString == today {
                        debugPrint("今天是否选过菜2--\(dateString)---\(today)")
                        isTodaySelected = true
                        break
                    }
                }

                /// 表示已经选择过了,就显示当天选择的蔬菜信息
                if isTodaySelected {
                    
                    //                    mainQueue {
                    //                        self.navigationItem.title = "已选择的蔬菜订单"
                    //                        self.collectionView.isHidden = true
                    //                        self.view.addSubview(self.tableView)
                    //                        self.view.insertSubview(self.headerView, aboveSubview: self.tableView)
                    //                        self.tableView.reloadData()
                    //                    }

                    /// 请求是否有已经选择过了配送的订单
                    let emptyV = EmptyView()
                    view.addSubview(emptyV)
                    emptyV.config = EmptyViewConfig(title: "您今天已经选择过配送的蔬菜了🥬,是否查看选择的蔬菜信息",
                                                    image: UIImage(named: "basket_paySuccess"),
                                                    btnTitle: "确定")
                    emptyV.snp.makeConstraints { (make) in
                        make.top.equalTo(kNavBarH+155)
                        make.left.bottom.right.equalTo(self.view)
                    }
                    
                    emptyV.sureBtnClosure = {
                        self.navigator.show(segue: .deliveryOrderInfo, sender: self)
                    }

                }else {
                    
                    ///  4. 之前没有选择过的话今天就阔以选选择蔬菜提交订单
                    view.addSubview(commitVew)
                    fetchDispatchMenu()
                }

            }else {
                
                ///  4. 之前没有选择过的话今天就阔以选选择蔬菜提交订单
                view.addSubview(commitVew)
                fetchDispatchMenu()
                
//                /// 请求是否有已经选择过了配送的订单
//                let emptyV = EmptyView()
//                view.addSubview(emptyV)
//                emptyV.config = EmptyViewConfig(title: "只能提前两天选菜,根据你选择的配送日期，今天无法选择配送的蔬菜🥬,是否查看所选蔬菜的历史订单",
//                                                image: UIImage(named: "basket_paySuccess"),
//                                                btnTitle: "确定")
//                emptyV.snp.makeConstraints { (make) in
//                    make.top.equalTo(kNavBarH+155)
//                    make.left.bottom.right.equalTo(self.view)
//                }
//
//                emptyV.sureBtnClosure = {
//                    self.navigator.show(segue: .deliveryOrderInfo, sender: self)
//                }
            }
        }
    }
    
    override func makeUI() {
        super.makeUI()
        
        view.backgroundColor = UIColor.white
        
        /// 1. 判断是否是vip
        if User.currentUser().isVip == 0 {
            
            if User.currentUser().mobile == developmentMan {
                let emptyView = EmptyPageForOrder.initFromNib
                emptyView.frame = CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH)
                emptyView.titleLab.text = "今天还不能配送选菜哦"
                emptyView.sureBtn.isHidden = true
                view.addSubview(emptyView)
            }else {
                // 不是vip提示联系客服 充值
                view.addSubview(emptyView)
                emptyView.config = EmptyViewConfig(title: "您暂不是会员用户,还没有该项服务,可联系我们的工作人员申请开通VIP", image: UIImage(named: "farm_delivery_nonmember"), btnTitle: "去开通")
                emptyView.snp.makeConstraints { (make) in
                    make.top.equalTo(kNavBarH)
                    make.left.bottom.right.equalTo(self.view)
                }
                emptyView.sureBtnClosure = {
                    let tipsView = SelectTipsView()
                    tipsView.titleLab.text = "立即联系客服申请VIP服务"
                    tipsView.detailLab.text = ""
                    tipsView.btnClosure = { index in
                        if index  == 2 {
                            callUpWith(linkMan) // 填写运营人员的电话号码
                        }
                    }
                }
            }
            
        }else {
            
            navigationItem.title = "配送选货"
            navigationItem.rightBarButtonItem = rightRecordItem
            
            view.addSubview(collectionView)
            view.addSubview(headerView)
            
            // 加载数据
            loadData()
        }
        
        // fetchDispatchMenu()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        headerView.addressView.sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.navigator.show(segue: Navigator.Scene.mineAddress, sender: self)
        }).disposed(by: rx.disposeBag)
        
        /// 修改配送的地址信息
        NotificationCenter.default.rx.notification(.userOrderAddressEdit).subscribe(onNext: { [weak self] (notification) in
            guard let self = self else { return }
            let addressInfo = notification.userInfo?[NSNotification.Name.userOrderAddressEdit.rawValue] as! UserAddressInfo
            self.headerView.addressView.tipLab.isHidden = true
            self.headerView.addressView.addressInfo = addressInfo
        }).disposed(by: rx.disposeBag)
        
        /// 设置用户的蔬菜配送时间
        dateViewDemo.dateView.sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            debugPrints("点击了蔬菜日期表的确认按钮")
            self.dateViewDemo.dismiss()
            self.settingDispatchData(tagArray: self.dateViewDemo.dateView.tagArray)
        }).disposed(by: rx.disposeBag)

        commitVew.orderBtn.rx.tap.subscribe(onNext: {  [weak self] (_) in
            guard let self = self else {
                debugPrints("没有self吗,zz")
                return
            }

            self.browseSelectedVegetablesList()
            
        }).disposed(by: rx.disposeBag)
    }
    
    
    /// 判断今天是否可以选菜
    func selectMenu() -> Bool {
        
        let week: Int = (Calendar.current as NSCalendar).components([NSCalendar.Unit.weekday], from: Date()).weekday! - 1
        
        var isSelect = false
        
        /// 显示当天能配送的
        switch week {
            
        case 0:
            if dispatchDate.wednesday {
                isSelect = true
                scheduleday = 3
            }
        case 1:
            if dispatchDate.thursday {
                isSelect = true
                scheduleday = 4
            }
        case 2:
            if dispatchDate.friday {
                isSelect = true
                scheduleday = 5
            }
        case 3:
            if dispatchDate.saturday {
                isSelect = true
                scheduleday = 6
            }
        case 4:
            if dispatchDate.sunday {
                isSelect = true
                scheduleday = 7
            }
        case 5:
            if dispatchDate.monday {
                isSelect = true
                scheduleday = 1
            }
        case 6:
            if dispatchDate.tuesday {
                isSelect = true
                scheduleday = 2
            }
        default:
            break
        }
        
        return isSelect
    }
    
    /// 让用户浏览所选择的蔬菜列表
    func browseSelectedVegetablesList() {

        let menuInfo = dispatchMenuInfo.filter { (item) -> Bool in
            if item.num == 0 {
                return false
            }
            return true
        }
        
        guard !menuInfo.isEmpty else {
            //ZYToast.showTopWithText(text: "您还没有选择所配送的蔬菜呢")
            MBProgressHUD.showInfo("您还没有选择所配送的蔬菜呢")
            return
        }
        
        /*
         企业用户 和 vip 用户没有什么其他区别， 唯一区别就是  企业用户正常下单不扣配送次数，然后支付的时候你们传参数0 就可以了，就是不花钱，只要我们有这个订单详情就好了
         还有一个逻辑是， 普通用户满98 包邮， VIP用户 在商城里包邮，但是扣配送次数。 这个由我这边逻辑去自动减
         0是非VIP 1是个人VIP 2是企业用户
         */
        
        switch User.currentUser().isVip {
            
        case 0:
            debugPrint("普通用户")
            browseOrderVC.orderView.bottomView.numLab.text = "-\(deliverynum)"
        case 1:
            debugPrint("vip用户")
            browseOrderVC.orderView.bottomView.numLab.text = "-\(deliverynum)"
        case 2:
            debugPrint("企业用户")
            browseOrderVC.orderView.bottomView.numLab.text = "免配配送"
        default:
            break
        }
        
        browseOrderVC.orderView.bottomView.totalCountLab.text = "\(Keepfigures(text: CGFloat(goodsWeight)))kg"
        browseOrderVC.orderView.dispatchMenuInfo = menuInfo
        browseOrderVC.show()
        browseOrderVC.commitOrderClosure = {
            debugPrints("点击了提交订单列表")
            self.createDispatchOrder()
        }
    }
    
    
    // MARK: - Lazy
    lazy var emptyView = EmptyView()
    lazy var headerView = DeliveryHeaderView.loadView()
    lazy var footerView = DeliveryFooterView.loadView()
    lazy var commitVew = DeliveryCommitOrderView.loadView()
    lazy var dateViewDemo = DeliveryDateViewController()
    lazy var browseOrderVC = DeliveryOrderViewController()
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH + 150, width: kScreenW, height: kScreenH-kNavBarH-150), style: .grouped)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.register(DeliveryTabCell.self, forCellReuseIdentifier: DeliveryTabCell.identifier)
        //view.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)  // 去除表格上放多余的空隙
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: kNavBarH+150, width: kScreenW, height: kScreenH-kNavBarH-kBottomViewH-150), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(DeliveryCollectionCell.self, forCellWithReuseIdentifier: DeliveryCollectionCell.identifier)
        return collectionView
    }()
    
    lazy var rightMsgItem = BarButtonItem(image: UIImage(named: "farm_message"), target: self, action: #selector(messageAction))
    lazy var rightRecordItem = BarButtonItem(image: UIImage(named: "farm_record"), target: self, action: #selector(recordAction))
    
    var sectionTitleView = CartSectionHeaderView().then { (view) in
        view.titleLab.text = "最近一次配送的菜单："
        view.titleLab.textColor = Color.theme1DD1A8
        view.titleLab.font = UIFont.systemFont(ofSize: 14)
    }
    
    // MARK: - Action
    
    @objc func recordAction() {
        self.navigator.show(segue: .deliveryOrderInfo, sender: self)
    }
    
    @objc func messageAction() {
        dateViewDemo.show()
    }
    
    // MARK: - Dispatch Methods
    
    func loadData() {
        
        //fetchUserBalance()
        //fetchDispatchDate()
        //settingDispatchData()
        //fetchDispatchMenu()
        //createDispatchOrder()
        //fetchDispatchOrderList()
        
        /// 2.获取用户地址和配送日期
        fetchUserAddressList()
        fetchDispatchDate()
    }
    
    /// 获取用户的默认地址信息
    func fetchUserAddressList() {
        
        var p = [String: Any]()
        p["user_id"] = User.currentUser().userId
        p["wid"] = wid
        p["fromplat"] = "iOS"
        
        WebAPITool.requestModelArrayWithData(WebAPI.userAddressList(p), model: UserAddressInfo.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            mainQueue {
                self.headerView.addressView.tipLab.isHidden = true
            }
            self.addressList = list
        }) { (error) in
            mainQueue {
                self.headerView.addressView.tipLab.isHidden = false
            }
            self.addressList = []
        }
    }
    
    ///  获取配送日期
    func fetchDispatchDate() {
        
        let params = ["userid": User.currentUser().userId]
        
        WebAPITool.requestModel(WebAPI.fetchDispatchDate(params), model: DispatchDateInfo.self, complete: { [weak self] (model) in
            debugPrints("配送的时间---\(model)")
            guard let self = self else { return }
            self.dispatchDate = model
            
//            var info = DispatchDateInfo()
//
//            info.monday = true
//
//            /// 星期二
//            info.tuesday  = true
//
//            /// 星期三
//            info.wednesday  = true
//
//            /// 星期四
//            info.thursday = true
//
//            /// 星期五
//            info.friday  = true
//
//            /// 星期六
//            info.saturday  = true
//
//            /// 星期天
//            info.sunday  = true
//
//
//            self.dispatchDate = info
            
        }) { (error) in
            debugPrints("获取配送日期失败---\(error)")
        }
    }
    
    /// 设置配送日程表
    func settingDispatchData(tagArray: [Int]) {
        
        let userId = User.currentUser().userId
        
        var params = [String: Any]()
        params["userid"] = userId
        params["monday"] = false
        params["tuesday"] = false
        params["wednesday"] = false
        params["thursday"] = false
        params["friday"] = false
        params["saturday"] = false
        params["sunday"] = false
        
        for item in tagArray.enumerated() {
            
            if item.element == 1 {
                params["monday"] = true
            }
            
            if item.element == 2 {
                params["tuesday"] = true
            }
            
            if item.element == 3 {
                params["wednesday"] = true
            }
            
            if item.element == 4 {
                params["thursday"] = true
            }
            
            if item.element == 5 {
                params["friday"] = true
            }
            
            if item.element == 6 {
                params["saturday"] = true
            }
            
            if item.element == 7 {
                params["sunday"] = true
            }
            
        }
        
        debugPrints("设置配送的日期参数---\(params)")
        
        HudHelper.showWaittingHUD(msg: "请稍后...")
        WebAPITool.request(WebAPI.settingDispatchDate(userId, params), complete: { (value) in
            HudHelper.hideHUD()
            if value.boolValue {
                self.fetchDispatchDate()
                MBProgressHUD.showSuccess("设置配送日期成功")
            }else {
                MBProgressHUD.showError("设置配送日期失败")
            }
        }) { (error) in
            HudHelper.hideHUD()
            debugPrints("设置配送的时间失败---\(error)")
        }
    }
    
    ///  获取所有用户的配送菜单列表
    func fetchDispatchMenu() {
        
        WebAPITool.requestModelArrayWithData(WebAPI.fetchDispatchMenu, model: DispatchMenuInfo.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            debugPrints("配送清单列表---\(list.count)")
            self.dispatchMenuInfo = list
            mainQueue {
                self.collectionView.reloadData()
            }
        }) { (error) in
            debugPrints("配送清单列表失败---\(error)")
        }
    }
    
    /// 创建用户的配送蔬菜订单
    func createDispatchOrder() {
        
        /// 所选择的菜品列表
        var orderList: [[String: Any]] = []
        
        for item in dispatchMenuInfo {
            
            if item.num > 0 {

                let dict: [String: Any]  = ["productid": item.productid,
                                            "quantity": item.num,
                                            "productname": item.producename,
                                            "focusImgUrl": item.focusImgUrl,
                                            "weight": item.unitweight]
                
                orderList.append(dict)
                
            }
            
        }
        
        var params = [String: Any]()
        params["userid"] = User.currentUser().userId
        params["weight"] = goodsWeight
        params["deliverynum"] = deliverynum
        params["scheduleday"] = scheduleday
        params["addressid"] = headerView.addressView.addressInfo.id
        
        debugPrints("配送蔬菜的参数---\(params)")
        debugPrints("配送蔬菜的参数body---\(orderList)")
        
        //params["dispatchProductLists"] = orderList
        
        HudHelper.showWaittingHUD(msg: "请稍后...")
        WebAPITool.request(WebAPI.createDispatchOrder(orderList, params), complete: { (value) in
            HudHelper.hideHUD()
            
            let status = value["status"].intValue
            
            if status == 1 {
                debugPrints("创建配送订单---\(value)")
                MBProgressHUD.showSuccess("订单提交成功!")
                self.navigationController?.popViewController(animated: true)
            }else {
                MBProgressHUD.showError("订单提交失败,请稍后再试")
                debugPrints("创建配送订单失败")
            }
        }) { (error) in
            HudHelper.hideHUD()
            MBProgressHUD.showError("订单提交失败,请稍后再试")
            debugPrints("创建配送订单失败")
        }
        
    }
    
    /// 获取配送订单列表（正在进行中，历史记录）
    func fetchDispatchOrderList() {
        
        var params = [String: Any]()
        params["userid"] = User.currentUser().userId
        params["status"] = 1  // status 1 等于在正在进行中的订单， status 2 是历史订单
        params["pageSize"] = 10
        params["pageIndex"] = 1
        
        WebAPITool.requestModelArrayWithData(WebAPI.dispatchOrderList(params), model: DispatchVegetablesInfo.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            self.vegetablesInfo = list
        }) { (error) in
            self.vegetablesInfo = []
            debugPrints("获取配送订单列表（正在进行中，历史记录）失败---\(error)")
        }
    }
    
    /// 获取配送订单详情
    func fetchDispatchOrderDetail() {
        
        var params = [String: Any]()
        params["userid"] = User.currentUser().userId
        params["dispatchid"] = 1  // status 1 等于在正在进行中的订单， status 2 是历史订单
        
        WebAPITool.requestModelWithKey(WebAPI.dispatchOrderList(params), model: DispatchOrderInfo.self, key: "page", complete: { (model) in
            debugPrints("获取配送订单详情---\(model)")
        }) { (error) in
            debugPrints("获取配送订单详情失败---\(error)")
        }
    }
}

extension DeliveryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vegetablesInfo.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vegetablesInfo[section].dispatchOrderDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryTabCell.identifier, for: indexPath) as! DeliveryTabCell
        cell.info = vegetablesInfo[indexPath.section].dispatchOrderDetail[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CartSectionHeaderView()
        view.titleLab.textColor = Color.theme1DD1A8
        view.titleLab.font = UIFont.systemFont(ofSize: 14)
        view.titleLab.text = "这是您\(vegetablesInfo[section].scheduleDay)配送的菜单："
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let info = vegetablesInfo[section]
        let view = DeliveryFooterView.loadView()
        view.numLab.text = "-\(info.deliverynum)"
        view.totalCountLab.text = Keepfigures(text: CGFloat(info.weight))+"Kg"
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 88
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //let offsetY = scrollView.contentOffset.y
        //headerView.frame = CGRect(x: 0, y: offsetY, width: kScreenW, height: 150)
    }
    
}

extension DeliveryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dispatchMenuInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeliveryCollectionCell.identifier, for: indexPath) as! DeliveryCollectionCell
        
        cell.Info = dispatchMenuInfo[indexPath.row]
        
        cell.addView.addDidClosure = { [weak self] num in
            guard let self = self else { return }
            var model = self.dispatchMenuInfo[indexPath.row]
            model.num = num
            self.dispatchMenuInfo[indexPath.row] = model
            self.calculateGoodsPrice()
        }

        cell.addView.minusDidClosure = { [weak self] num in
            guard let self = self else { return }
            var model = self.dispatchMenuInfo[indexPath.row]
            model.num = num
            self.dispatchMenuInfo[indexPath.row] = model
            self.calculateGoodsPrice()
        }
        
        return cell
    }
    
    func calculateGoodsPrice() {
        
        var price: CGFloat = 0
        var goodsNum = 0  // 表示购物的蔬菜数量
        
        dispatchMenuInfo.forEach { (item) in
            if item.num != 0 {
                price += CGFloat(item.num) * item.unitweight
                goodsNum += 1
            }
        }
        
        if goodsNum > 0 {
            /// 设置Badge的偏移量, Badge中心点默认为其父视图的右上角 Set Badge offset, Badge center point defaults to the top right corner of its parent view
            ///
            /// - Parameters:
            ///   - x: X轴偏移量 (x<0: 左移, x>0: 右移) axis offset (x <0: left, x> 0: right)
            ///   - y: Y轴偏移量 (y<0: 上移, y>0: 下移) axis offset (Y <0: up,   y> 0: down)
            commitVew.leftImg.pp.moveBadge(x: -10, y: 35)
            commitVew.leftImg.pp.addBadge(number: goodsNum)
            commitVew.leftImg.pp.setBadgeLabel { (lab) in
                lab.backgroundColor = Color.theme1DD1A8
            }
        }
        
        /// 商品总重量
        goodsWeight = price/1000.0
        
        /// 蔬菜重量每超过5Kg，多加一次配送次数
        deliverynum = Int(ceil(Double(goodsWeight)/5))
        
        debugPrints("选择的蔬菜重量---\(Keepfigures(text: goodsWeight))")
        commitVew.totalLab.text = "\(Keepfigures(text: goodsWeight))kg"
        
        /*
         企业用户 和 vip 用户没有什么其他区别， 唯一区别就是  企业用户正常下单不扣配送次数，然后支付的时候你们传参数0 就可以了，就是不花钱，只要我们有这个订单详情就好了
         还有一个逻辑是， 普通用户满98 包邮， VIP用户 在商城里包邮，但是扣配送次数。 这个由我这边逻辑去自动减
         0是非VIP 1是个人VIP 2是企业用户
         */
        
        switch User.currentUser().isVip {
        case 0:
            debugPrint("普通用户")
            commitVew.timesLab.text = "配送次数：-\(deliverynum)"
        case 1:
            debugPrint("vip用户")
            commitVew.timesLab.text = "配送次数：-\(deliverynum)"
        case 2:
            debugPrint("企业用户")
            commitVew.timesLab.text = "免配配送"
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let specificationVC = SpecificationViewController()
        //specificationVC.show()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenW/3, height: kScreenW/3+80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
}


/*
 
 iOS 常用的向上,向下取整, 四舍五入函数
 向上取整:ceil(x),返回不小于x的最小整数;
 
 向下取整:floor(x),返回不大于x的最大整数;
 
 四舍五入:round(x)
 
 截尾取整函数:trunc(x)
 */

/*
 
 let emptyV = EmptyView()
 view.addSubview(emptyV)
 emptyV.config = EmptyViewConfig(title: "你已经选过配送的蔬菜啦,请在历史订单中查看所选择的蔬菜配送信息🥬",
 image: UIImage(named: "farm_delivery_nonmember"),
 btnTitle: "确定")
 emptyV.snp.makeConstraints { (make) in
 make.top.equalTo(kNavBarH+155)
 make.left.bottom.right.equalTo(self.view)
 }
 
 emptyV.sureBtnClosure = {
 let recordVC = DeliveryOrderInfoViewController()
 self.navigationController?.pushViewController(recordVC, animated: true)
 }
 
 */
