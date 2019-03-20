//
//  MineViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/24.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import ObjectMapper

class MineViewController: TableViewController {
    
    // MARK: - Property
    
    let window = Application.shared.window!
    
    var balance: UserBanlance = UserBanlance() {
        didSet {
            debugPrints("用户的额度信息---\(balance)")
            
            headerView.priceLab.text = "\(balance.creditbalance)"
            headerView.cardLab.text = "\(balance.weightbalance)"
            headerView.timesLab.text = "\(balance.deliverybalance)"
            
            //            if User.hasUser() && User.currentUser().isVip != 0 {
            //                headerView.priceLab.text = "\(balance.creditbalance)"
            //                headerView.cardLab.text = "\(balance.weightbalance)"
            //                headerView.timesLab.text = "\(balance.deliverybalance)"
            //            }
        }
    }
    
    override func makeUI() {
        super.makeUI()
        
        navigationItem.rightBarButtonItems = [settingItem,messageItem]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.register(MineTabCell.self, forCellReuseIdentifier: MineTabCell.identifier)
        
        tableView.uHead = MJDIYHeader(refreshingBlock: {
            self.fetchUserBalance()
            self.fetchUserInfo()
        })
        
        NotificationCenter.default.rx.notification(Notification.Name.cartOrderPaySuccess).subscribe(onNext: { (_) in
            debugPrints("订单支付成功-刷新用户的账户余额信息")
            self.fetchUserBalance()
        }).disposed(by: rx.disposeBag)
        
        NotificationCenter.default.rx.notification(.updateUserInfo).subscribe(onNext: { (_) in
            debugPrints("刷新用户的信息")
            self.fetchUserInfo()
        }).disposed(by: rx.disposeBag)
        
        fetchUserBalance()
        fetchUserInfo()
    }
    
    func fetchUserBalance() {
        
        let params = ["userid": User.currentUser().userId]
        
        WebAPITool.requestModel(WebAPI.userBalance(params), model: UserBanlance.self, complete: { (model) in
            self.tableView.uHead.endRefreshing()
            self.balance = model
        }) { (error) in
            self.tableView.uHead.endRefreshing()
        }

    }
    
    func fetchUserInfo() {
        
        var params = [String: Any]()
        params["userid"] = User.currentUser().userId
        
        WebAPITool.requestModel(WebAPI.fetchUserInfo(params), model: User.self, complete: { (model) in
            model.save()
            delay(by: 0.5, closure: {
                self.navigationController?.popViewController(animated: true)
            })
        }) { (error) in
            HudHelper.hideHUD()
        }
    }

    override func bindViewModel() {
        super.bindViewModel()
        
        if User.hasUser() {
            headerView.user = User.currentUser()
        }
        
        headerView.headerBtn.rx.tap.subscribe(onNext: {  (_) in
            let hud = MineHeaderModifyView()
            hud.imageView.lc_setImage(with: User.currentUser().userImg)
        }).disposed(by: rx.disposeBag)
        
        headerView.orderView.fukuanBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.navigator.show(segue: .mineOrder(index: 0), sender: self)
        }).disposed(by: rx.disposeBag)
        
        headerView.orderView.peisongBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.navigator.show(segue: .mineOrder(index: 1), sender: self)
        }).disposed(by: rx.disposeBag)
        
        headerView.orderView.shouhuoBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.navigator.show(segue: .mineOrder(index: 2), sender: self)
        }).disposed(by: rx.disposeBag)
        
        headerView.orderView.orderBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.navigator.show(segue: .mineOrder(index: 3), sender: self)
        }).disposed(by: rx.disposeBag)
        
        headerView.walletBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.navigator.show(segue: .mineWallet(info: self.balance), sender: self)
        }).disposed(by: rx.disposeBag)
        
        headerView.vegetablesBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.navigator.show(segue: .mineVegetables(info: self.balance), sender: self)
        }).disposed(by: rx.disposeBag)
        
        headerView.memberBtn.rx.tap.subscribe(onNext: { (_) in
            guard User.currentUser().isVip == 0 else {return}
            
            let tipsView = SelectTipsView()
            tipsView.titleLab.text = "立即联系客服申请VIP服务"
            tipsView.detailLab.text = ""
            tipsView.btnClosure = { index in
                if index  == 2 {
                    callUpWith(linkMan) // 填写运营人员的电话号码
                }
            }
            //self.navigator.show(segue: .mineMember(info: self.balance), sender: self)
        }).disposed(by: rx.disposeBag)
        
    }
    
    // MARK: - Lazy
    lazy var titleArray = ["配送订单","我的收藏","联系客服","关于我们","设置","退出登录"]
    lazy var headerView = MineHeaderView.loadView()
    lazy var settingItem = BarButtonItem(image: UIImage(named: "mine_setting"), target: self, action: #selector(settingAction))
    lazy var messageItem = BarButtonItem(image: UIImage(named: "farm_message"), target: self, action: #selector(messageAction))
    
    // MARK: - Public methods
    @objc func settingAction() {
        navigator.show(segue: .mineSetting, sender: self)
    }
    
    @objc func messageAction() {
        navigator.show(segue: .mineMessage, sender: self)
    }
    
}


extension MineViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineTabCell.identifier, for: indexPath) as! MineTabCell
        cell.titleLab.text = titleArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigator.show(segue: .deliveryOrderInfo, sender: self)
        case 2:
            
            if User.hasUser() && User.currentUser().isVip == 0 {
                let tipsView = SelectTipsView()
                tipsView.titleLab.text = "立即联系客服申请VIP服务"
                tipsView.detailLab.text = ""
                tipsView.btnClosure = { index in
                    if index  == 2 {
                        callUpWith(linkMan) // 填写运营人员的电话号码
                    }
                }
            }else {
                let tipsView = SelectTipsView()
                tipsView.titleLab.text = "立即联系客服咨询售后服务"
                tipsView.detailLab.text = ""
                tipsView.btnClosure = { index in
                    if index  == 2 {
                        callUpWith(linkMan) // 填写运营人员的电话号码
                    }
                }
            }
            
        case 3:
            self.navigator.show(segue: .mineAbout, sender: self)
        case 4:
            self.navigator.show(segue: .mineSetting, sender: self)
        case 5:
            
            let tipsView = SelectTipsView()
            tipsView.titleLab.text = "是否退出账号登录?"
            tipsView.detailLab.text = ""
            tipsView.btnClosure = { index in
                if index  == 2 {
                    User.removeCurrentUser()
                    self.navigator.show(segue: .login, sender: self, transition: .root(window: self.window))
                }
            }
        default:
            break
        }
    }
    
    
    
}
