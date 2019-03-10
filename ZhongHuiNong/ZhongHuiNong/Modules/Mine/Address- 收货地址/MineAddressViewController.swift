//
//  MineAddressViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineAddressViewController: ViewController {

    // MARK: - Property
    var addressList: [UserAddressInfo] = [] {
        didSet {
            fadeInOnDisplay {
                self.tableView.alpha = 1
                self.view.addSubview(self.tableView)
                mainQueue {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Override
    override func makeUI() {
        super.makeUI()
        navigationItem.title = localized("地址管理")
        view.addSubview(self.bottomView)
        fetchAddressList()
    }

    override func bindViewModel() {
        super.bindViewModel()
        bottomView.sureBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            let info = UserAddressInfo()
            self.navigator.show(segue: .mineAddressModify(info: info), sender: self)
        }).disposed(by: rx.disposeBag)
        
        NotificationCenter.default.rx.notification(.userAddressDidChange).subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.fetchAddressList()
        }).disposed(by: rx.disposeBag)
    }
    
    // MARK: - Lazy
    lazy var bottomView = MineAddressBottomView.loadView()
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH-kBottomViewH), style: .plain)
        view.backgroundColor = UIColor.hexColor(0xFAFAFA)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.alpha = 0
        view.showsVerticalScrollIndicator = false
        view.register(MineAddressTabCell.self, forCellReuseIdentifier: MineAddressTabCell.identifier)
        return view
    }()
    
    // MARK: - Action
    func fetchAddressList() {
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

}

extension MineAddressViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineAddressTabCell.identifier, for: indexPath) as! MineAddressTabCell
        cell.addressInfo = addressList[indexPath.row]
        cell.editBtnClicked = { [weak self] in
            guard let self = self else { return }
            let info = self.addressList[indexPath.row]
            self.navigator.show(segue: .mineAddressModify(info: info), sender: self)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addressInfo = addressList[indexPath.row]
        let dict = [NSNotification.Name.userOrderAddressEdit.rawValue: addressInfo]
        NotificationCenter.default.post(name: .userOrderAddressEdit, object: nil, userInfo: dict)
        self.navigationController?.popViewController(animated: true)
    }
    
}
