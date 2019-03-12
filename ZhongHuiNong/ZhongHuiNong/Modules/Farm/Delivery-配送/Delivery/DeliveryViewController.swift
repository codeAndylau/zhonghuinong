//
//  DeliveryViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import MBProgressHUD

/// 配送选货
class DeliveryViewController: ViewController {
    
    // MARK: Preparty
    
    var isMember = true
    var isSelected = false
    
    var goodsWeight: CGFloat = 0  // 商品总重量
    var deliverynum: Int = 1      // 配送需要减去的次数
    var scheduleday: Int = 0      // 配送的日期： 星期一
    var deliveryday: String = ""
    
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
            }else {
                debugPrints("两个接口数据没有请求完成")
            }
        }
    }
    
    /// 获取配送的日期
    var dispatchDate: DispatchDateInfo = DispatchDateInfo() {
        didSet {
            
            /// 1. 先判断是否选择过配送时间
            if dispatchDate.monday == false && dispatchDate.tuesday == false && dispatchDate.wednesday == false &&
                dispatchDate.thursday == false && dispatchDate.friday == false && dispatchDate.saturday == false && dispatchDate.sunday == false {
                mainQueue {
                    self.dateViewDemo.show()
                }
                
            }else {
                
                /// 2. 表示已经选择过了配送蔬菜的日期: 星期1-7 只少两天，并且提前两天选菜
                
                // 显示用户所选的配送日期
                headerView.dateView.dispatchDate = dispatchDate
                
                debugPrints("是否可以选择菜--\(selectMenu())")
                
                /// 3. 判断当前能否有阔以选择的蔬菜日期
                if selectMenu() {
                    
                    /// 4. 再去判断当前是否已经选择过了配送的蔬菜
                    fetchDispatchOrderList()
                    
                }else {
                    
                    /// 请求是否有已经选择过了配送的订单
                    let emptyV = EmptyView()
                    view.addSubview(emptyV)
                    emptyV.config = EmptyViewConfig(title: "只能提前两天选菜,根据你选择的配送日期，今天无法选择配送的蔬菜🥬",
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
                deliveryday = "星期三"
            }
        case 1:
            if dispatchDate.thursday {
                isSelect = true
                scheduleday = 4
                deliveryday = "星期四"
            }
        case 2:
            if dispatchDate.friday {
                isSelect = true
                scheduleday = 5
                deliveryday = "星期五"
            }
        case 3:
            if dispatchDate.saturday {
                isSelect = true
                scheduleday = 6
                deliveryday = "星期六"
            }
        case 4:
            if dispatchDate.sunday {
                isSelect = true
                scheduleday = 7
                deliveryday = "星期天"
            }
        case 5:
            if dispatchDate.monday {
                isSelect = true
                scheduleday = 1
                deliveryday = "星期一"
            }
        case 6:
            if dispatchDate.tuesday {
                isSelect = true
                scheduleday = 2
                deliveryday = "星期二"
            }
        default:
            break
        }
        
        return isSelect
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
                
                /// 判断当前是否已经选择过了
                var isSelected = false
                for item in vegetablesInfo {
                    if item.scheduleDay == deliveryday  {
                        isSelected = true
                        break
                    }
                }
                
                /// 表示已经选择过了
                if isSelected {
                    
                    collectionView.isHidden = true
                    tableView.addSubview(headerView)
                    
                    let info = vegetablesInfo[0]
                    sectionTitleView.titleLab.text = "这是您\(info.scheduleDay)配送的菜单："
                    
                    footerView.numLab.text = "-\(info.deliverynum)"
                    footerView.totalCountLab.text = Keepfigures(text: CGFloat(info.weight))+"Kg" 
                    
                    view.addSubview(tableView)
                    mainQueue {
                        self.tableView.reloadData()
                    }
                    
                }else {
                    /// 之前没有选择过的话今天就阔以选菜就直接选择
                    view.addSubview(commitVew)
                    fetchDispatchMenu()
                }

            }else {
                
                /// 请求是否有已经选择过了配送的订单
                let emptyV = EmptyView()
                view.addSubview(emptyV)
                emptyV.config = EmptyViewConfig(title: "只能提前两天选菜,根据你选择的配送日期，今天无法选择配送的蔬菜🥬",
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
    
    /// 剩余配送次数
    var balanceInfo: UserBanlance = UserBanlance() {
        didSet {
            //commitVew.timesLab.text = "剩余免配送次数：\(balanceInfo.deliverybalance)"
        }
    }
    
    override func makeUI() {
        super.makeUI()
        
        //        debugPrints("今天星期---\(Date().week())")
        //        debugPrints("返回不小x的最小整数---\(ceil(2.1))")
        
        view.backgroundColor = UIColor.white
        
        /// 1. 判断是否是vip
        if User.currentUser().isVip == 0 {
            
            navigationItem.title = "配送选货"
            navigationItem.rightBarButtonItem = rightRecordItem
            
            collectionView.addSubview(headerView)
            view.addSubview(collectionView)
            
            // 加载数据
            loadData()
            
        }else {
            
            // 不是vip提示联系客服 充值
            view.addSubview(emptyView)
            emptyView.config = EmptyViewConfig(title: "您暂不是会员用户,还没有该项服务,可联系我们的工作人员申请开通VIP", image: UIImage(named: "farm_delivery_nonmember"), btnTitle: "去开通")
            emptyView.snp.makeConstraints { (make) in
                make.top.equalTo(kNavBarH)
                make.left.bottom.right.equalTo(self.view)
            }
            emptyView.sureBtnClosure = {
                let phone = linkMan  // 填写运营人员的电话号码
                callUpWith(phone)
            }
        }
        
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
        
        browseOrderVC.orderView.bottomView.numLab.text = "-\(deliverynum)"
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
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH), style: .plain)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.tableFooterView = footerView
        view.showsVerticalScrollIndicator = false
        view.register(DeliveryTabCell.self, forCellReuseIdentifier: DeliveryTabCell.identifier)
        view.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH-kBottomViewH), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(DeliveryCollectionCell.self, forCellWithReuseIdentifier: DeliveryCollectionCell.identifier)
        return collectionView
    }()
    
    lazy var rightMsgItem = BarButtonItem(image: UIImage(named: "farm_message"), target: self, action: #selector(messageAction))
    lazy var rightRecordItem = BarButtonItem(image: UIImage(named: "farm_record"), target: self, action: #selector(recordAction))
    
    lazy var sectionTitleView = CartSectionHeaderView().then { (view) in
        view.titleLab.text = "最近一次配送的菜单："
        view.titleLab.textColor = Color.theme1DD1A8
        view.titleLab.font = UIFont.systemFont(ofSize: 14)
    }
    
    // MARK: - Action
    
    @objc func recordAction() {
        let recordVC = DeliveryOrderInfoViewController()
        self.navigationController?.pushViewController(recordVC, animated: true)
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
        
        fetchUserAddressList()
        fetchDispatchDate()
    }
    
    /// 获取配送次数
    func fetchUserBalance() {
        let params = ["userid": User.currentUser().userId]
        WebAPITool.requestModel(WebAPI.userBalance(params), model: UserBanlance.self, complete: { [weak self] (model) in
            guard let self = self else { return }
            self.balanceInfo = model
        }) { (error) in
            debugPrints("获取用户配送次数失败---\(error)")
        }
        
    }
    
    /// 获取用户的默认地址信息
    func fetchUserAddressList() {
        
        var p = [String: Any]()
        p["user_id"] = User.currentUser().userId
        p["wid"] = wid
        p["fromplat"] = "iOS"
        
        WebAPITool.requestModelArrayWithData(WebAPI.userAddressList(p), model: UserAddressInfo.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            self.addressList = list
        }) { (error) in
            ZYToast.showCenterWithText(text: error)
        }
    }
    
    ///  获取配送日期
    func fetchDispatchDate() {
        
        let params = ["userid": User.currentUser().userId]
        WebAPITool.requestModel(WebAPI.fetchDispatchDate(params), model: DispatchDateInfo.self, complete: { [weak self] (model) in
            debugPrints("配送的时间---\(model)")
            guard let self = self else { return }
            self.dispatchDate = model
        }) { (error) in
            debugPrints("配送的时间失败---\(error)")
        }
    }
    
    /// 设置配送日期
    func settingDispatchData(tagArray: [Int]) {
        
        let userId = User.currentUser().userId
        
        var params = [String: Any]()
        params["userid"] = userId
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
                debugPrints("设置配送的时间---\(value)")
                self.fetchDispatchDate()
                ZYToast.showTopWithText(text: "设置配送日期成功")
            }else {
                ZYToast.showTopWithText(text: "设置配送日期失败")
                debugPrints("设置配送的时间失败")
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vegetablesInfo[0].dispatchOrderDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryTabCell.identifier, for: indexPath) as! DeliveryTabCell
        cell.info = vegetablesInfo[0].dispatchOrderDetail[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.sectionTitleView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        headerView.frame = CGRect(x: 0, y: offsetY, width: kScreenW, height: 150)
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
        
        dispatchMenuInfo.forEach { (item) in
            if item.num != 0 {
                price += CGFloat(item.num) * item.unitweight
            }
        }
        
        /// 商品总重量
        goodsWeight = price/1000.0
        
        /// 蔬菜重量每超过5Kg，多加一次配送次数
        deliverynum = Int(ceil(Double(goodsWeight)/5))
        
        debugPrints("选择的蔬菜重量---\(Keepfigures(text: goodsWeight))")
        commitVew.totalLab.text = "\(Keepfigures(text: goodsWeight))kg"
        commitVew.timesLab.text = "配送次数：-\(deliverynum)"
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let specificationVC = SpecificationViewController()
        //specificationVC.show()
    }
    
    //定义每个Cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenW/3, height: kScreenW/3+80)
    }
    
    //定义每个Section的四边间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
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
