//
//  MineWalletViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineWalletViewController: TableViewController {
    
    var banlance: UserBanlance = UserBanlance() {
        didSet {
            headerView.balanceLab.text = "¥\(banlance.creditbalance)"
        }
    }
    
    override func makeUI() {
        super.makeUI()
        
        navigationItem.title = localized("钱包")
        
        if User.hasUser() && User.currentUser().isVip == 0 {
            
            let emptyView = EmptyView()
            view.addSubview(emptyView)
            
            emptyView.config = EmptyViewConfig(title: "您暂不是会员用户,还没有该项服务", image: UIImage(named: "farm_delivery_nonmember"), btnTitle: "去开通")
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
            
        }else {
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableHeaderView = headerView
            tableView.tableFooterView = nomoreView
            tableView.register(MineWalletTabCell.self, forCellReuseIdentifier: MineWalletTabCell.identifier)
            debugPrints("是否设置了支付密码---\(User.currentUser().isPayPassword)")
        }
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        headerView.chongzhiBtn.rx.tap.subscribe(onNext: { (_) in
           
            let tipsView = SelectTipsView()
            tipsView.titleLab.text = "立即联系客服充值"
            tipsView.detailLab.text = ""
            tipsView.btnClosure = { index in
                if index  == 2 {
                    callUpWith(linkMan)
                }
            }
            
        }).disposed(by: rx.disposeBag)
        
        
        PayPasswordDemo.inputCompleteClosure = { [weak self] psd in
            guard let self = self else { return }
            debugPrints("设置的支付密码---\(psd)")
            self.settingPayPassword(psd: psd)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if User.hasUser() && User.currentUser().isVip != 0 && !User.currentUser().isPayPassword  {
            PayPasswordDemo.show()
        }
        
    }
    
    // MARK: - Lzay
    lazy var headerView = MineWalletHeaderView.loadView()
    lazy var nomoreView = NoMoreFooterView.loadView()
    lazy var PayPasswordDemo = MineSettingPayPsdViewController()
    
    // MARK: - Action
    
    func settingPayPassword(psd: String) {
        
        var params = [String: Any]()
        params["userid"] = User.currentUser().userId
        params["paymentpassword"] = psd
        
        debugPrints("设置密码的参数---\(params)")
        
        HudHelper.showWaittingHUD(msg: "请稍后...")
        WebAPITool.request(WebAPI.settingPayPassword(params), complete: { (value) in
            HudHelper.hideHUD()
            if value.boolValue {
                defaults.set(true, forKey: Configs.Identifier.SettingPayPsd)
                ZYToast.showCenterWithText(text: "设置支付密码成功")
                NotificationCenter.default.post(name: .updateUserInfo, object: nil)
                self.fetchUserInfo()
            }else {
                ZYToast.showCenterWithText(text: "设置支付密码失败")
            }
            debugPrints("设置支付密码成功---\(value)")
        }) { (error) in
            HudHelper.hideHUD()
            debugPrints("设置支付密码失败---\(error)")
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
    
}

extension MineWalletViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineWalletTabCell.identifier, for: indexPath) as! MineWalletTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    
}
