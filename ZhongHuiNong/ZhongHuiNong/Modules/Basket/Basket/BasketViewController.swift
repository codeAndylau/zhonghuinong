//
//  BasketViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/24.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 购物车
class BasketViewController: TableViewController {
    
    var cartList: [CartGoodsInfo] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func makeUI() {
        super.makeUI()
        
        navigationItem.leftBarButtonItem = cartItem
        navigationItem.rightBarButtonItem = messageItem
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CartTabCell.self, forCellReuseIdentifier: CartTabCell.identifier)
        tableView.uempty = UEmptyView(verticalOffset: -kNavBarH, tapClosure: { })
        
        tableView.uHead = MJDIYHeader(refreshingBlock: {
            self.fetchShopingCartList(isRefresh: true)
        })
        
        view.addSubview(settleView)
        
        fetchShopingCartList()
    }

    override func bindViewModel() {
        super.bindViewModel()
        
        settleView.settlementBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let list = self.cartList.filter({ (item) -> Bool in
                if item.checked { return true }
                return false
            })
            self.navigator.show(segue: .shoppingOrder(list: list), sender: self)
        }).disposed(by: rx.disposeBag)
        
        settleView.selectBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.settleViewAllSelectAction()
        }).disposed(by: rx.disposeBag)
        
        NotificationCenter.default.rx.notification(.goodsDetailCartClicked).subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.fetchShopingCartList(isRefresh: true)
        }).disposed(by: rx.disposeBag)
    }

    
    // MARK: - Lazy
    lazy var cartItem = BarButtonItem.cartItem()
    
    lazy var emptyView = EmptyView.loadView()
    
    lazy var settleView = SettlementView.loadView()
    
    lazy var sectionView = CartSectionHeaderView.loadView()
    
    lazy var messageItem = BarButtonItem(image: UIImage(named: "farm_message"), target: self, action: #selector(messageAction))
    
    // MARK: - Public methods
    
    var isType = false
    
    @objc func messageAction() {
        
        isType = !isType
        if isType {
            settleView.type = .edit
        }else {
            settleView.type = .normal
        }
        
   }
    
    /// 获取购物车
    func fetchShopingCartList(isRefresh: Bool = false) {
        
        guard User.hasUser() else {
            debugPrints("你还没有登录账号")
            return
        }
        
        var p = [String: Any]()
        p["userid"] = User.currentUser().userId
        
        WebAPITool.requestModelArrayWithData(WebAPI.fetchCart(p), model: CartGoodsInfo.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            if isRefresh {
                self.tableView.uHead.endRefreshing()
                self.cartList.removeAll()
            }
            self.cartList = list
            self.calculateGoodsPrice()
            self.checkSelectStatus()
        }) { (error) in
            if isRefresh {
                self.tableView.uHead.endRefreshing()
            }
        }
        
    }
    
    // MARK: - 购物车购买逻辑
    
    /// 结算时图全选
    func settleViewAllSelectAction() {
        
        settleView.selectBtn.isSelected = !settleView.selectBtn.isSelected
        
        // 所有商品取消选中和全选
        if settleView.selectBtn.isSelected {
            for i in 0..<cartList.count {
                var model = cartList[i]
                model.checked = true
                cartList[i] = model
            }
        }else {
            for i in 0..<cartList.count {
                var model = cartList[i]
                model.checked = false
                cartList[i] = model
            }
        }
        
        tableView.reloadData()
        calculateGoodsPrice()
        
    }
    
    /// 价格的计算 和 商品总计个数
    func calculateGoodsPrice() {
        
        var salePrice: CGFloat = 0
        var costPrice: CGFloat = 0
        
        var num = 0
        
        cartList.forEach { (item) in
            if item.checked {
                costPrice += item.marketprice * CGFloat(item.quantity)
                salePrice += item.sellprice * CGFloat(item.quantity)
                num += Int(item.quantity)
            }
        }
        
        debugPrints("销售价格和成本价格总和----\(Keepfigures(text: salePrice))---\(Keepfigures(text: costPrice))")
        
        settleView.memberPriceLab.text = "¥" + Keepfigures(text: salePrice)
        settleView.nonMemberPriceLab.text = "¥" + Keepfigures(text: costPrice)
        
        var isSettle = false  // 是否可以去结算
        
        for item in cartList {
            // 思路是只要有一个被选中，即可 去结算，反之只有全部没有被选中才不能去结算
            if item.checked {
                isSettle = true
                break
            }
        }
        
        if isSettle {
            settleView.settlementBtn.setTitle("去结算\(num)", for: .normal)
            settleView.settlementBtn.isUserInteractionEnabled = true
            settleView.settlementBtn.alpha = 1
        }else {
            settleView.settlementBtn.setTitle("去结算", for: .normal)
            settleView.settlementBtn.isUserInteractionEnabled = false
            settleView.settlementBtn.alpha = 0.5
        }
        
    }
    
    /// 检查是否已经是全选状态了
    func checkSelectStatus() {
        
        var realRowNum = 0
        var totalSelected = 0
        
        cartList.forEach { (item) in
            realRowNum += 1
            if item.checked {
                totalSelected += 1
            }
        }
        
        if realRowNum == totalSelected {
            settleView.selectBtn.isSelected = true
        }else {
            settleView.selectBtn.isSelected = false
        }
        
    }

}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTabCell.identifier, for: indexPath) as! CartTabCell
        cell.goodsInfo = cartList[indexPath.row]
        cell.selectionStyle = .none
        cell.selectBtnClosure = {
            
            var model = self.cartList[indexPath.row]
            model.checked = !model.checked
            self.cartList[indexPath.row] = model
            
            debugPrints("cell的选中状态---\(model.checked)")
            
            self.tableView.reloadData()
            self.checkSelectStatus()
            self.calculateGoodsPrice()
        }
        
        cell.addView.addDidClosure = { num in
            
            var model = self.cartList[indexPath.row]
            model.quantity = num
            self.cartList[indexPath.row] = model
            
            self.checkSelectStatus()
            self.calculateGoodsPrice()
        }
        
        cell.addView.minusDidClosure = { num in
            
            var model = self.cartList[indexPath.row]
            model.quantity = num
            self.cartList[indexPath.row] = model
            
            self.checkSelectStatus()
            self.calculateGoodsPrice()
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

