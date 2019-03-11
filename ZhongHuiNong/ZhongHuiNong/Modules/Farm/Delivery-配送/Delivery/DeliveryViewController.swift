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
    
    var goodsWeight: Double = 0  // 商品总重量
    var deliverynum: Int = 1     // 配送需要减去的次数
    var scheduleday: Int = 0     // 配送的日期： 星期一
    
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
                dispatchDate.thursday == false && dispatchDate.friday && dispatchDate.saturday == false && dispatchDate.sunday {
                mainQueue {
                    self.dateViewDemo.show()
                }
                
            }else {
                
                /// 2. 表示已经选择过了配送蔬菜的日期 ： 星期1-7 只少两天，并且提前两天选菜
                
                // 显示用户所选的配送日期
                headerView.dateView.dispatchDate = dispatchDate
                
                debugPrints("是否可以选择菜--\(selectMenu())")
                
                if !selectMenu() {
                    
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
                }else {
                    /// 请求是否有已经选择过了配送的订单
                    fetchDispatchOrderList()
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
    
    /// 所有用户可以选择的菜品
    var dispatchMenuInfo: [DispatchMenuInfo] = [] {
        didSet {
            
        }
    }
    
    /// 判断当前用户是否已经选择过蔬菜了
    var vegetablesInfo: [DispatchVegetablesInfo] = [] {
        didSet {
            if vegetablesInfo.count > 0 {
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
            }else {
                /// 没有选择就可以获取蔬菜列表，进行选择
                fetchDispatchMenu()
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
        
        debugPrints("今天星期---\(Date().week())")
        
        debugPrints("返回不小x的最小整数---\(ceil(2.1))")
        
        view.backgroundColor = UIColor.white
        
        /// 1. 判断是否是vip
        if User.currentUser().isVip == 0 {
            
            navigationItem.rightBarButtonItems = [rightMsgItem, rightRecordItem]
            navigationItem.title = "配送选货"
            view.addSubview(collectionView)
            view.addSubview(commitVew)
            collectionView.addSubview(headerView)
            
            // 加载数据
            loadData()
            
        }else {
            
            // 不是vip提示联系客服 充值
            view.addSubview(emptyView)
            emptyView.config = EmptyViewConfig(title: "您暂不是会员用户,还没有该项服务", image: UIImage(named: "farm_delivery_nonmember"), btnTitle: "去开通")
            emptyView.snp.makeConstraints { (make) in
                make.top.equalTo(kNavBarH)
                make.left.bottom.right.equalTo(self.view)
            }
            emptyView.sureBtnClosure = {
                let phone = "18782967728"  // 填写运营人员的电话号码
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
            
            self.createDispatchOrder()
            
        }).disposed(by: rx.disposeBag)
    }
    
    
    // MAKR: - Lazy
    lazy var emptyView = EmptyView()
    lazy var headerView = DeliveryHeaderView.loadView()
    lazy var footerView = DeliveryFooterView.loadView()
    lazy var commitVew = DeliveryCommitOrderView.loadView()
    lazy var dateViewDemo = DeliveryDateViewController()
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH-kBottomViewH), style: .plain)
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
        p["user_id"] = 3261
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
    
    ///  获取所有用户的配送菜单
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
        
        
        /*
         let orderVC = DeliveryOrderViewController()
         orderVC.show()
         */
        
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
            if value.boolValue {
                debugPrints("创建配送订单---\(value)")
                MBProgressHUD.showSuccess("订单提交成功!")
                self.navigationController?.popViewController(animated: true)
            }else {
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
        
        WebAPITool.requestModelArrayWithData(WebAPI.dispatchOrderList(params), model: DispatchVegetablesInfo.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            self.vegetablesInfo = list
        }) { (error) in
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryTabCell.identifier, for: indexPath) as! DeliveryTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
        
        let weight = price/1000.0
        
        deliverynum = Int(ceil(goodsWeight))
        
        goodsWeight = Double(weight)
        
        
        debugPrints("选择的蔬菜重量---\(Keepfigures(text: weight))")
        commitVew.totalLab.text = "\(Keepfigures(text: weight))kg"
        commitVew.timesLab.text = "配送次数：-\(ceil(goodsWeight))"
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


