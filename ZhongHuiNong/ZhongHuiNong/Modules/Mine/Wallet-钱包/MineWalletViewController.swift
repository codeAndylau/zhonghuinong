//
//  MineWalletViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineWalletViewController: TableViewController {

    var isSettingPsd = false
    
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
                let phone = linkMan  // 填写运营人员的电话号码
                callUpWith(phone)
            }
            
        }else {
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableHeaderView = headerView
            tableView.tableFooterView = nomoreView
            tableView.register(MineWalletTabCell.self, forCellReuseIdentifier: MineWalletTabCell.identifier)
            isSettingPsd = defaults.bool(forKey: Configs.Identifier.SettingPayPsd)
            debugPrints("是否设置了支付密码---\(isSettingPsd)")
        }
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        PayPasswordDemo.inputCompleteClosure = { [weak self] psd in
            guard let self = self else { return }
            debugPrints("设置的支付密码---\(psd)")
            self.settingPayPassword(psd: psd)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if User.hasUser() && User.currentUser().isVip != 0 && !isSettingPsd  {
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
                ZYToast.showCenterWithText(text: "设置支付密码成功!!!")
            }else {
                ZYToast.showCenterWithText(text: "设置支付密码失败!!!")
            }
            debugPrints("设置支付密码成功---\(value)")
        }) { (error) in
            HudHelper.hideHUD()
            debugPrints("设置支付密码失败---\(error)")
        }
    }
    
}

extension MineWalletViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineWalletTabCell.identifier, for: indexPath) as! MineWalletTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    
}
