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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = nomoreView
        tableView.register(MineWalletTabCell.self, forCellReuseIdentifier: MineWalletTabCell.identifier)
        isSettingPsd = defaults.bool(forKey: Configs.Identifier.SettingPayPsd)
        debugPrints("是否设置了支付密码---\(isSettingPsd)")
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
        if !isSettingPsd {
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
        params["userid"] = 3261
        params["paymentpassword"] = psd
        
        debugPrints("设置密码的参数---\(params)")
        
        HudHelper.showWaittingHUD(msg: "请稍后...")
        WebAPITool.request(WebAPI.settingPayPassword(params), complete: { (value) in
            HudHelper.hideHUD()
            if value.boolValue {
                defaults.set(true, forKey: Configs.Identifier.SettingPayPsd)
            }else {
                ZYToast.showCenterWithText(text: "这是失败!!!")
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
