//
//  DeliveryOrderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/19.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryOrderView: View {

    let tipsLab = Label().then { (lab) in
        lab.text = "本次所选蔬菜列表清单"
        lab.textColor = Color.themeColor
        lab.font = UIFont.boldSystemFont(ofSize: 15)
    }
    

    let cancelBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "basket_cancel"), for: .normal)
    }
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect.zero, style: .plain)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.register(DeliveryTabCell.self, forCellReuseIdentifier: DeliveryTabCell.identifier)
        return view
    }()
    
    let bottomView = DeliveryFooterView.loadView()
    
    let sureBtn = Button().then { (btn) in
        btn.setTitle("提交订单", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.cuttingCorner(radius: 22)
    }
    
    override func makeUI() {
        super.makeUI()

        addSubview(tipsLab)
        addSubview(cancelBtn)
        addSubview(tableView)
        addSubview(bottomView)
        addSubview(sureBtn)

    }
    
    override func updateUI() {
        super.updateUI()

        tipsLab.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(12)
            make.left.equalTo(self).offset(30)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.right.top.equalTo(self)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(50)
            make.left.right.equalTo(self)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalTo(sureBtn.snp.top).offset(-20)
            make.left.right.equalTo(self)
            make.height.equalTo(88)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-40)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-100)
            make.height.equalTo(44)
        }
        
    }

    /// - Public methods
    class func loadView() -> DeliveryOrderView {
        let view = DeliveryOrderView()
        view.frame = CGRect(x: 0, y: kScreenH*0.25, width: kScreenW, height: kScreenH*0.75)
        view.backgroundColor = Color.whiteColor
        let corners: UIRectCorner = [.topLeft, .topRight]
        view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }
    
    /// 所有用户可以选择的菜品
    var dispatchMenuInfo: [DispatchMenuInfo] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
}

extension DeliveryOrderView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dispatchMenuInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryTabCell.identifier, for: indexPath) as! DeliveryTabCell
        let info = dispatchMenuInfo[indexPath.row]
        cell.leftImg.lc_setImage(with: info.focusImgUrl)
        cell.titleLab.text = info.producename
        cell.countLab.text = "\(info.unitweight)g"
        cell.numLab.text = "x\(info.num)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
