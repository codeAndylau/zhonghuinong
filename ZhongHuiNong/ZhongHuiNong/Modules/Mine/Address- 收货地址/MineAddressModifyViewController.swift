//
//  MineAddressModifyViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineAddressModifyViewController: ViewController {

    override func makeUI() {
        super.makeUI()
        navigationItem.title = "编辑收货人"
        view.addSubview(tableView)
        view.addSubview(bottomView)
        
        bottomView.sureBtn.setTitle("保存", for: .normal)
        bottomView.sureBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }

            self.navigationController?.popViewController(animated: true)
            self.tableView.visibleCells.forEach({ (cell) in
                let cell = cell as! MineAddressModifyTabCell
                debugPrints("地址内容---\(String(describing: cell.textField.text))")
            })
            
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
    
    override func updateUI() {
        super.updateUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lazy
    
    lazy var picker = MineAddressPickerViewController()
    
    lazy var bottomView = MineAddressBottomView.loadView()
    
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

}

extension MineAddressModifyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineAddressModifyTabCell.identifier, for: indexPath) as! MineAddressModifyTabCell
        if indexPath.row == 0 {
            cell.titleLab.text = "联系人"
            cell.textField.placeholder = "请填写收货人姓名"
        }
        
        if indexPath.row == 1 {
            cell.titleLab.text = "手机号"
            cell.textField.placeholder = "请填写收货人手机号"
        }
        
        if indexPath.row == 2 {
            cell.titleLab.text = "所在地区"
            cell.textField.placeholder = ""
            cell.textField.isEnabled = false
            cell.sureBtn.isHidden = false
            cell.arrowImg.isHidden = false
            cell.sureBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.picker.show()
            }).disposed(by: rx.disposeBag)
        }
        
        if indexPath.row == 3 {
            cell.titleLab.text = "详细地址"
            cell.textField.placeholder = "详情地址例: 1号楼1505号"
        }        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
