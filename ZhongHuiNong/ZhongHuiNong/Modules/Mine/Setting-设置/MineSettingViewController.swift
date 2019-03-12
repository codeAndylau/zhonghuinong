//
//  MineSettingViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineSettingViewController: ViewController {

    let user = User.currentUser()
    
    override func makeUI() {
        super.makeUI()
        navigationItem.title = "设置"
        view.addSubview(tableView)
    }

    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lazy
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-kNavBarH-44), style: .plain)
        view.backgroundColor = UIColor.hexColor(0xFAFAFA)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.register(MineSettingTabCell.self, forCellReuseIdentifier: MineSettingTabCell.identifier)
        return view
    }()
}

extension MineSettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 2
        case 2:
            return 1
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MineSettingTabCell.identifier, for: indexPath) as! MineSettingTabCell
        // FIXME: 后期优化
        if indexPath.section == 0 {
            cell.arrowImg.isHidden = true
            if indexPath.row == 0 {
                cell.arrowImg.isHidden = true
                cell.titleLab.text = "头像"
                cell.headerImg.lc_setImage(with: user.userImg)
            }
            if indexPath.row == 1 {
                cell.isLine = true
                cell.isTitle = true
                cell.titleLab.text = "昵称"
                cell.detailLab.text = user.username
            }
        }
        
        if indexPath.section == 1  {
            cell.isTitle = true
            cell.isLine = true
            if indexPath.row == 0 {
                cell.titleLab.text = "手机号"
                cell.detailLab.text = user.mobile == "" ? "暂未绑定手机" : user.mobile
            }
            if indexPath.row == 1 {
                cell.arrowImg.isHidden = true
                cell.titleLab.text = "微信号"
                cell.detailLab.text = "已绑定"
            }
        }
        
        if indexPath.section == 2 {
            cell.isArrow = true
            cell.titleLab.text = "收货地址"
        }
        
        if indexPath.section == 3 {
            cell.isSwitch = true
            if indexPath.row == 0 {
                cell.switchView.isOn = true
                cell.titleLab.text = "接受新消息"
            }
            if indexPath.row == 1 {
                cell.titleLab.text = "声音提醒"
            }
            if indexPath.row == 2{
                cell.isLine = true
                cell.titleLab.text = "振动"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && indexPath.row == 0 {
            self.navigator.show(segue: .bindingMobile, sender: self)
        }
        
        if indexPath.section == 2 {
            self.navigator.show(segue: .mineAddress, sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return View()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return 0
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = View().then { (view) in
            view.backgroundColor = UIColor.hexColor(0xFAFAFA)
        }
        return view
    }
    
    
}
