//
//  MineAddressModifyViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineAddressModifyViewController: ViewController {

    // MARK: - Property
    var addressInfo = UserAddressInfo()
    
    // MARK: - Override
    override func makeUI() {
        super.makeUI()
        
        navigationItem.title = localized("编辑收货人")
        view.addSubview(tableView)
        view.addSubview(bottomView)
        
        if addressInfo.id != defaultId {
            navigationItem.rightBarButtonItem = deleteItem
        }
    }

    override func bindViewModel() {
        super.bindViewModel()
        
        bottomView.sureBtn.setTitle("保存", for: .normal)
        bottomView.sureBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            var p = [String: String]()
            for item in self.tableView.visibleCells.enumerated() {
                
                let cell = item.element as! MineAddressModifyTabCell
                let text = cell.textField.text!
                
                if item.offset == 0 {
                    p["linkMan"] = text
                }
                
                if item.offset == 1 {
                    p["mobile"] = text
                }
                
                if item.offset == 2 {
                    p["preaddress"] = text
                }
                
                if item.offset == 3 {
                    p["address"] = text
                }
            }
            
            let linkMan = p["linkMan"]
            let mobile = p["mobile"]
            let preaddress = p["preaddress"]
            let address = p["address"]
            
            guard linkMan != "" else {
                ZYToast.showCenterWithText(text: "请输入联系人")
                return
            }
            
            guard mobile != "" else {
                ZYToast.showCenterWithText(text: "请输入联系电话")
                return
            }
            
            guard preaddress != "" else {
                ZYToast.showCenterWithText(text: "请输入所在区域")
                return
            }
            
            guard address != "" else {
                ZYToast.showCenterWithText(text: "请输入详细地址")
                return
            }
            
            self.saveUserAddressInfo(p)
            
        }).disposed(by: rx.disposeBag)
        
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        tap.rx.event.subscribe(onNext: { [weak self]  (_) in
            guard let self = self else { return }
            self.view.endEditing(true)
        }).disposed(by: rx.disposeBag)
        
        picker.selectedAreaCompleted = { [weak self] (p,c,d,t) in
            guard let self = self else { return }
            debugPrints("选择的区域---\(p)-\(c)-\(d)-\(t)")
            let cell = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! MineAddressModifyTabCell
            cell.textField.text = "\(p)-\(c)-\(d)-\(t)"
        }
    }
    
    // MARK: - Lazy
    lazy var picker = MineAddressPickerViewController()
    lazy var bottomView = MineAddressBottomView.loadView()
    lazy var deleteItem = BarButtonItem(image: UIImage(named: "mine_address_delete"), target: self, action: #selector(deleteAction))
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH), style: .plain)
        view.backgroundColor = UIColor.white
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.register(MineAddressModifyTabCell.self, forCellReuseIdentifier: MineAddressModifyTabCell.identifier)
        return view
    }()
    
    // MARK: - Action
    func saveUserAddressInfo(_ p: [String: String]) {
        
        var params = [String: Any]()
        params["user_id"] = "3261"  //"\(User.currentUser().userId)"
        params["linkMan"] = p["linkMan"]
        params["preaddress"] = p["preaddress"]
        params["address"] = p["address"]
        params["mobile"] = p["mobile"]
        params["youbian"] = "000000"
        params["isdefault"] = "true"
        params["address_id"] = "\(addressInfo.id)"
        params["wid"] = "5"
        params["fromplat"] = "iOS"

        debugPrints("用户地址参数---\(params)")

        HudHelper.showWaittingHUD(msg: "请求中...")
        WebAPITool.request(.editAddress(params), complete: { (value) in
            HudHelper.hideHUD(FromView: nil)
            let code = value["code"].intValue
            if code == 0 {
                delay(by: 0.5, closure: {
                    mainQueue {
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
            debugPrints("编辑用户地址信息---\(value)")
        }) { (error) in
            debugPrints("编辑用户地址信息出错---\(error)")
            ZYToast.showCenterWithText(text: error)
        }

    }

    @objc func deleteAction() {
        
        let cancel = UIAlertAction(title: "我点错了", style: UIAlertAction.Style.default, handler: nil)
        let sure = UIAlertAction(title: "确定删除", style: UIAlertAction.Style.cancel) { (_) in
            
            var params = [String: Any]()
            params["address_id"] = self.addressInfo.id
            params["user_id"] = "3261"
            params["wid"] = 5
            
            WebAPITool.request(WebAPI.deleteUserAddress(params), complete: { (value) in
                debugPrints("删除用户地址信息---\(value)")
                let code = value["code"].intValue
                if code == 0 {
                    delay(by: 0.5, closure: {
                        mainQueue {
                            self.navigationController?.popViewController(animated: true)
                        }
                    })
                }
            }) { (error) in
                debugPrints("删除用户地址信息---\(error)")
                ZYToast.showCenterWithText(text: error)
            }
        }
        showAlert("删除后无法回复哦!", message: nil, alertActions: [cancel,sure])
    }

}

// MARK: - UITableViewDataSource
extension MineAddressModifyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineAddressModifyTabCell.identifier, for: indexPath) as! MineAddressModifyTabCell
        cell.cell_IndexPath = indexPath
        cell.cellTFClosure = { [weak self] (text, index) in
            guard let self = self else { return }
            
            if index == 0 {
                self.addressInfo.linkMan = text
            }
            
            if index == 1 {
                self.addressInfo.mobile = text
            }
            
            if index == 2 {
                self.addressInfo.preaddress = text
            }
            
            if index == 3 {
                self.addressInfo.address = text
            }
        }
        
        if indexPath.row == 0 {
            cell.titleLab.text = "联系人"
            cell.textField.placeholder = "请填写收货人姓名"
            cell.textField.text = addressInfo.linkMan
        }
        
        if indexPath.row == 1 {
            cell.titleLab.text = "手机号"
            cell.textField.placeholder = "请填写收货人手机号"
            cell.textField.text = addressInfo.mobile
            cell.textField.keyboardType = .numberPad
        }
        
        if indexPath.row == 2 {
            cell.titleLab.text = "所在地区"
            cell.textField.placeholder = ""
            cell.textField.text = addressInfo.preaddress
            
            cell.textField.isEnabled = false
            cell.sureBtn.isHidden = false
            cell.arrowImg.isHidden = false
            cell.sureBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.view.endEditing(true)
                self.picker.show()
            }).disposed(by: rx.disposeBag)
        }
        
        if indexPath.row == 3 {
            cell.titleLab.text = "详细地址"
            cell.textField.placeholder = "详情地址例: 1号楼1505号"
            cell.textField.text = addressInfo.address
        }        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

}
