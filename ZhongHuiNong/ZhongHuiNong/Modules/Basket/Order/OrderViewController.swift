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
    
    var isSettingPsd = false
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
            if addressList.count == 0 {
                headerView.addressView.tipLab.isHidden = false
            }else {
                headerView.addressView.tipLab.isHidden = true
            }
            refreshValue()
        }
    }
    
    var payMoney: CGFloat = 0
    
    var goodsList: [CartGoodsInfo] = [] {
        
        didSet {
            
            var salePrice: CGFloat = 0
            var costPrice: CGFloat = 0
            
            var num = 0
            
            goodsList.forEach { (item) in
                costPrice += item.marketprice * CGFloat(item.quantity)
                salePrice += item.sellprice * CGFloat(item.quantity)
                num += 1
            }
            
            debugPrints("订单销售价格和成本价格总和----\(Keepfigures(text: salePrice))---\(Keepfigures(text: costPrice))")

            /*
             企业用户 和 vip 用户没有什么其他区别， 唯一区别就是  企业用户正常下单不扣配送次数，然后支付的时候你们传参数0 就可以了，就是不花钱，只要我们有这个订单详情就好了
             还有一个逻辑是， 普通用户满98 包邮， VIP用户 在商城里包邮，但是扣配送次数。 这个由我这边逻辑去自动减
             0是非VIP 1是个人VIP 2是企业用户
             */
            
            switch User.currentUser().isVip {
            case 0:
                
                debugPrints("普遍用户")
                /// 普遍用户 超过98 则需要免运费
                if costPrice > 98 {
                    isFreight = true
                }
                payMoney = CGFloat(costPrice)
                paySureView.moneyLab.text = "¥" + Keepfigures(text: costPrice)
                paySureView.priceLab.text = ""
                
            case 1:
                
                debugPrints("VIP用户")
                
                isFreight = true
                payMoney = CGFloat(salePrice)
                paySureView.moneyLab.text = "¥" + Keepfigures(text: salePrice)
                paySureView.priceLab.text = "已优惠¥" + "\(Keepfigures(text: costPrice - salePrice))"
                
            case 2:
                
                /// 企业用
                debugPrints("企业VIP")
                isFreight = true
                payMoney = 0
                paySureView.moneyLab.text = "¥0"
                paySureView.priceLab.text = "您是企业用户,可直接购买"
                
            default: break
                
            }
            paySureView.numLab.text = "共\(num)件"
        }
    }
    
    override func makeUI() {
        super.makeUI()
        navigationItem.title = localized("确认订单")
        isSettingPsd = User.currentUser().isPayPassword
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
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kBottomViewH, right: 0)
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
        
//        NotificationCenter.default.rx.notification(.cartOrderPaySuccess).subscribe(onNext: { (_) in
//            debugPrints("订单支付成功回到提交订单界面")
//            self.navigationController?.popViewController(animated: true)
//        }).disposed(by: rx.disposeBag)
        
        
        /// 弹出支付密码框，设置支付密码后，回调
        PayPasswordDemo.inputCompleteClosure = { [weak self] psd in
            guard let self = self else { return }
            debugPrints("设置的支付密码---\(psd)")
            self.settingPayPassword(psd: psd)
        }
        
        /// 支付成功后退回根试图控制器
        paySelectDemo.PayPasswordDemo.paySuccessClosure = {
            
            // 1: 订单支付成功。更新用户的信息
            NotificationCenter.default.post(name: .cartOrderPaySuccess, object: nil)
            
            // 2: 如何连续dismiss 2个VC视图控制器（以及直接跳回根视图）
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            
            // 3: 显示支付成功的界面，给用户一个友好的提示
            self.paySuccessDemo.paySuccessView.moneyLab.text = "实付:¥\(Keepfigures(text: self.payMoney))"
            self.paySuccessDemo.show()
            
        }
        
        /// 支付成功后点击的支付界面的按钮的事件操作
        paySuccessDemo.btnClosure = { index in
            
            if index == 1 {
                self.tabBarController?.selectedIndex = 3
                self.navigationController?.popViewController(animated: false)
            }
            
            if index == 2 {
                self.tabBarController?.selectedIndex = 1
                self.navigationController?.popViewController(animated: false)
            }
        }
        
        paySuccessDemo.disMissClosure = {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    /// 设置支付密码
    func settingPayPassword(psd: String) {
        
        var params = [String: Any]()
        params["userid"] = User.currentUser().userId
        params["paymentpassword"] = psd
        
        debugPrints("设置密码的参数---\(params)")
        
        HudHelper.showWaittingHUD(msg: "请稍后...")
        WebAPITool.request(WebAPI.settingPayPassword(params), complete: { (value) in
            HudHelper.hideHUD()
            if value.boolValue {
                self.isSettingPsd = true
                defaults.set(true, forKey: Configs.Identifier.SettingPayPsd)
                ZYToast.showCenterWithText(text: "设置支付密码成功!!!")
                NotificationCenter.default.post(name: .updateUserInfo, object: nil)
                debugPrints("设置支付密码成功---\(value)")
            }else {
                ZYToast.showCenterWithText(text: "设置支付密码失败!!!")
            }
        }) { (error) in
            HudHelper.hideHUD()
            debugPrints("设置支付密码失败---\(error)")
        }
    }
    
    /// 验证用户是否绑定了手机
    func bindingPhone() {
        
        /// 0: 判断是否绑定了手机号码
        /// 1: 判断是否是vip
        /// 2: 是否绑定了支付密码
        /// 3: 然后在提交订单
        
        if User.hasUser() && User.currentUser().mobile == "" {
            navigator.show(segue: .bindingMobile, sender: self)
        }else {
                 if isSettingPsd {
                commitOrder()
            }else {
                showNoticebar(text: "请先设置支付密码", type: NoticeBarDefaultType.info)
                PayPasswordDemo.show()
            }
        }
    }
    
    /// 提交订单
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
        params["product_amount"] = "\(payMoney)"
        params["productLists"] = productLists
        
        debugPrints("创建订单参数---\(params)")
        
        WebAPITool.requestModel(WebAPI.createOrder(params), model: CartOrderInfo.self, complete: { (model) in
            debugPrints("创建订单成功---\(model)")
            MBProgressHUD.showSuccess("订单创建成功")

            if model.orderNumber != "" {
                // MARK: TODO === 确认支付
                self.surePay(model.orderNumber)
            }else {
                ZYToast.showCenterWithText(text: "订单编号有误!")
            }

        }) { (error) in
            debugPrints("创建订单出错---\(error)")
            MBProgressHUD.showError("订单创建失败")
        }
        
    }
    
    func surePay(_ order_no: String) {
        
        paySelectDemo.balance = balance.creditbalance
        paySelectDemo.money = payMoney
        paySelectDemo.order_no = order_no
        paySelectDemo.show()
        
        /// 应该支付的money
        paySelectDemo.PayPasswordDemo.paySureView.payLab.text = "¥\(Keepfigures(text: CGFloat(payMoney)))"
        
    }
    
    // MARK: - Lazy
    
    lazy var headerView = OrderHeaderView.loadView()
    
    lazy var paySureView = PaySureView.loadView()
    
    // 支付成功后显示的界面
    lazy var paySuccessDemo = PaySuccessViewController()
    
    lazy var paySelectDemo = PaySelectViewController()
    
    /// 设置支付密码框
    lazy var PayPasswordDemo = MineSettingPayPsdViewController()
    
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
