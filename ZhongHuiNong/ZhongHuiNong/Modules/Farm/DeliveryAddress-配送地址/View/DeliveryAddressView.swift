//
//  DeliveryAddressView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/19.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryAddressView: View {

    let titleLab = Label().then { (lab) in
        lab.text = "修改地址"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    let cancelBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "basket_cancel"), for: .normal)
    }
    
    let tipsLab = Label().then { (lab) in
        lab.text = "选择选项后，自动跳转上一个页面"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 18)
    }
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect.zero, style: .plain)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.register(DeliveryAddressTabCell.self, forCellReuseIdentifier: DeliveryAddressTabCell.identifier)
        return view
    }()
    
    let sureBtn = Button().then { (btn) in
        btn.setTitle("+添加地址", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.cuttingCorner(radius: 22)
    }
    
    // MAKR: - property
    var cellModifyDidClosure: ((Int)->())?
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(cancelBtn)
        addSubview(tableView)
        addSubview(tipsLab)
        addSubview(sureBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.centerY.equalTo(titleLab)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).inset(40)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-100)
            make.height.equalTo(44)
        }
        
        tipsLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(sureBtn.snp.top).offset(-25)
            make.centerX.equalTo(self)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(50)
            make.bottom.equalTo(tipsLab.snp.top).offset(-10)
        }
    }
    
    /// - Public methods
    class func loadView() -> DeliveryAddressView {
        let view = DeliveryAddressView()
        view.frame = CGRect(x: 0, y: kScreenH*0.45, width: kScreenW, height: kScreenH*0.55)
        view.backgroundColor = Color.whiteColor
        let corners: UIRectCorner = [.topLeft, .topRight]
        view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }

}

extension DeliveryAddressView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryAddressTabCell.identifier, for: indexPath) as! DeliveryAddressTabCell
        cell.modifyBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            self?.cellModifyDidClosure?(indexPath.row)
        }).disposed(by: rx.disposeBag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
