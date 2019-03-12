//
//  OrderViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import MBProgressHUD

/// 确定订单界面
class OrderViewController: TableViewController {

    // MARK: - Property
    
    var isFreight = false // 是否免运费
    
    func refreshValue() {
        
        if addressList.count > 0 && balance.id != defaultId {
            
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
            
            fadeInOnDisplay {
                mainQueue {
                    self.tableView.reloadData()
                }
            }
        }else {
            debugPrints("两个接口数据没有请求完成")
        }
        
    }
    
    var balance: UserBanlance = UserBanlance() {
        didSet {
            refreshValue()
        }
    }
    
    var addressList: [UserAddressInfo] = [] {
        didSet {
            refreshValue()
        }
    }
    
    var payMoney: Double = 0
    
    var goodsList: [CartGoodsInfo] = [] {
        didSet {
            
            var salePrice: CGFloat = 0
            var costPrice: CGFloat = 0
            
            var num = 0
            
            goodsList.forEach { (item) in
                costPrice += item.marketprice * CGFloat(item.quantity)
                salePrice += item.sellprice * CGFloat(item.quantity)
                num += Int(item.quantity)
            }
            
            debugPrints("订单销售价格和成本价格总和----\(Keepfigures(text: salePrice))---\(Keepfigures(text: costPrice))")
            
            if costPrice > salePrice {
                paySureView.priceLab.text = "已优惠¥" + "\(Keepfigures(text: costPrice - salePrice))"
            }
            
            /// 超过168 则需要免运费
            if salePrice > 168 {
                isFreight = true
                payMoney = Double(salePrice)
                paySureView.moneyLab.text = "¥" + Keepfigures(text: salePrice)
            }else {
                payMoney = Double(salePrice+8)
                paySureView.moneyLab.text = "¥" + Keepfigures(text: salePrice+8)
            }
            paySureView.numLab.text = "共\(num)件"
        }
    }
    
    override func makeUI() {
        super.makeUI()
        navigationItem.title = localized("确认订单")
        setupTab()
        fetchUserAddressList()
        fetchUserBalance()
    }
    
    func setupTab() {

        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = Color.backdropColor
        tableView.tableHeaderView = headerView
        tableView.register(VegetableTabCell.self, forCellReuseIdentifier: VegetableTabCell.identifier)
        tableView.addSubview(paySureView)
        view.addSubview(self.tableView)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        /// 提交订单
        paySureView.sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.bindingPhone()
        }).disposed(by: rx.disposeBag)
        
        headerView.addressView.sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.navigator.show(segue: Navigator.Scene.mineAddress, sender: self)
        }).disposed(by: rx.disposeBag)
        
        NotificationCenter.default.rx.notification(.userOrderAddressEdit).subscribe(onNext: { [weak self] (notification) in
            guard let self = self else { return }
            let addressInfo = notification.userInfo?[NSNotification.Name.userOrderAddressEdit.rawValue] as! UserAddressInfo
            debugPrints("用户选择地址信息---\(addressInfo)")
            self.headerView.addressView.addressInfo = addressInfo
        }).disposed(by: rx.disposeBag)
        
        NotificationCenter.default.rx.notification(Notification.Name.cartOrderPaySuccess).subscribe(onNext: { (_) in
            debugPrints("订单支付成功回到提交订单界面")
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: rx.disposeBag)
    }
    
    /// 验证用户是否绑定了手机
    func bindingPhone() {
        
        if User.hasUser() && User.currentUser().mobile == "" {
            navigator.show(segue: .bindingMobile, sender: self)
        }else {
            commitOrder()
        }
    }
    
    func commitOrder() {
        
        guard headerView.addressView.addressInfo.id != defaultId else {
            ZYToast.showCenterWithText(text: "您还没有填写收货地址")
            return
        }
        
        var productLists: [[String: Any]] = []

        for item in goodsList {
            let dict = ["productid": item.productid, "quantity": Int(item.quantity)]
            productLists.append(dict)
        }

        var params = [String: Any]()

        params["user_id"] = User.currentUser().userId
        params["remark"] = "暂无备注"
        params["addressid"] = headerView.addressView.addressInfo.id
        params["express_fee"] = isFreight == true ? "0" : "8"
        params["total_amount"] = "\(payMoney)"
        params["productLists"] = productLists

        debugPrints("创建订单参数---\(params)")

        HudHelper.showWaittingHUD(msg: "创建订单中...")
        WebAPITool.requestModel(WebAPI.createOrder(params), model: CartOrderInfo.self, complete: { (model) in
            debugPrints("创建订单成功---\(model)")
            HudHelper.hideHUD()
            MBProgressHUD.showSuccess("订单创建成功")

            if model.orderNumber != "" {
                // MARK: TODO === 确认支付
                self.surePay(model.orderNumber)
            }else {
                ZYToast.showCenterWithText(text: "订单编号有误!")
            }

        }) { (error) in
            debugPrints("创建订单出错---\(error)")
            HudHelper.hideHUD()
        }
                
    }
    
    func surePay(_ order_no: String) {
        
        paySelectDemo.balance = balance.creditbalance
        paySelectDemo.money = payMoney
        paySelectDemo.order_no = order_no
        paySelectDemo.show()
        
        /// 支付成功后退回根试图控制器
        paySelectDemo.PayPasswordDemo.paySuccessClosure = {
            // MARK: 如何连续dismiss 2个VC视图控制器（以及直接跳回根视图）
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Lazy
    
    lazy var headerView = OrderHeaderView.loadView()
    
    lazy var paySureView = PaySureView.loadView()
    
    lazy var paySelectDemo = PaySelectViewController()
    
    
    // MARK: - Public methods
    
    func fetchUserAddressList() {
        var p = [String: Any]()
        p["user_id"] = User.currentUser().userId
        p["wid"] = wid
        p["fromplat"] = "iOS"
        WebAPITool.requestModelArrayWithData(WebAPI.userAddressList(p), model: UserAddressInfo.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            self.addressList = list
        }) { (error) in
            self.addressList = []
            //ZYToast.showCenterWithText(text: error)
        }
    }
    
    func fetchUserBalance() {
        let params = ["userid": User.currentUser().userId]
        WebAPITool.requestModel(WebAPI.userBalance(params), model: UserBanlance.self, complete: { (model) in
            self.balance = model
        }) { (error) in
            debugPrints("请求额度出错---\(error)")
        }
    }
}

extension OrderViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VegetableTabCell.identifier, for: indexPath) as! VegetableTabCell
        cell.selectionStyle = .none
        cell.goodsList = goodsList
        cell.isFreight = isFreight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(44*3 + goodsList.count*60 + 14)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        paySureView.frame = CGRect(x: 0, y: kScreenH-kBottomViewH+offsetY, width: kScreenW, height: kBottomViewH)
    }

}
