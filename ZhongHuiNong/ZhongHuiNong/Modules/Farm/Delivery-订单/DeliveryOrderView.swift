//
//  DeliveryOrderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/19.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DeliveryOrderView: View {

    let topView = View().then { (view) in
        view.backgroundColor = Color.whiteColor
    }
    
    let day2Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周二", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
    }
    
    let day2View = View()
    let day2HeightView = View()
    
    let day5Btn = Button(type: .custom).then { (btn) in
        btn.setTitle("周五", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8, alpha: 0.4)
    }
    
    let day5View = View()
    let day5HeightView = View()
    
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
        btn.setTitle("确认", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.cuttingCorner(radius: 22)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(topView)
        addSubview(cancelBtn)
        addSubview(tableView)
        addSubview(bottomView)
        addSubview(sureBtn)

//        topView.addSubview(day2View)
//        topView.addSubview(day2HeightView)
//
//        topView.addSubview(day5View)
//        topView.addSubview(day5HeightView)
        
        topView.addSubview(day2Btn)
        topView.addSubview(day5Btn)

    }
    
    override func updateUI() {
        super.updateUI()
        
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(44)
        }
        
        day2Btn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        
//        day2View.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(30)
//            make.centerY.equalToSuperview()
//            make.width.equalTo(45)
//            make.height.equalTo(30)
//        }
        
//        day2HeightView.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(30)
//            make.centerY.equalToSuperview()
//            make.width.equalTo(45)
//            make.height.equalTo(30)
//        }
        
        day5Btn.snp.makeConstraints { (make) in
            make.left.equalTo(day2Btn.snp.right).offset(40)
            make.centerY.equalToSuperview()
            make.width.equalTo(45)
            make.height.equalTo(30)
        }
        
//        day5View.snp.makeConstraints { (make) in
//            make.left.equalTo(day2Btn.snp.right).offset(40)
//            make.centerY.equalToSuperview()
//            make.width.equalTo(45)
//            make.height.equalTo(30)
//        }
        
//        day5HeightView.snp.makeConstraints { (make) in
//            make.left.equalTo(day2Btn.snp.right).offset(40)
//            make.centerY.equalToSuperview()
//            make.width.equalTo(45)
//            make.height.equalTo(30)
//        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.right.top.equalTo(self)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        dayBtnAction(day2View)
//        dayBtnHeightAction(day2HeightView)
//
//        dayBtnAction(day5View)
//        dayBtnHeightAction(day5HeightView)
//
//        day2View.isHidden = true
//        day5HeightView.isHidden = true
        
    }
    
    func day2Height() {
        day5HeightView.isHidden = true
        day2View.isHidden = true
        
        day5View.isHidden = false
        day2HeightView.isHidden = false
    }
    
    func day5Height() {
        
        day5HeightView.isHidden = false
        day2View.isHidden = false
        
        day5View.isHidden = true
        day2HeightView.isHidden = true
    }
    
    func dayBtnAction(_ sender: View) {
        
        // strokeCode
        let borderLayer1 = CALayer()
        borderLayer1.frame = sender.bounds
        borderLayer1.backgroundColor = UIColor.orange.cgColor //UIColor.hexColor(0x1DD1A8, alpha: 0.4).cgColor
        borderLayer1.cornerRadius = sender.bounds.height/2
        sender.layer.insertSublayer(borderLayer1, at: 0)
        
        // fillCode
        let bgLayer1 = CALayer()
        bgLayer1.frame = sender.bounds.insetBy(dx: 2.5, dy: 2.5)
        bgLayer1.backgroundColor = UIColor.hexColor(0x1DD1A8, alpha: 0.5).cgColor
        bgLayer1.cornerRadius = sender.bounds.insetBy(dx: 2.5, dy: 2.5).height/2
        sender.layer.insertSublayer(bgLayer1, at: 0)
    }
    
    func dayBtnHeightAction(_ sender: View) {
        
        // strokeCode
        let borderLayer1 = CALayer()
        borderLayer1.frame = sender.bounds
        borderLayer1.backgroundColor = UIColor.hexColor(0x1DD1A8, alpha: 0.4).cgColor
        borderLayer1.cornerRadius = sender.bounds.height/2
        sender.layer.insertSublayer(borderLayer1, at: 0)
        // fillCode
        let bgLayer1 = CALayer()
        bgLayer1.frame = sender.bounds.insetBy(dx: 2.5, dy: 2.5)
        bgLayer1.backgroundColor = UIColor.hexColor(0x1DD1A8).cgColor
        bgLayer1.cornerRadius = sender.bounds.insetBy(dx: 2.5, dy: 2.5).height/2
        sender.layer.insertSublayer(bgLayer1, at: 0)
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

    var dataArray: Int = 6 {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
}

extension DeliveryOrderView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryTabCell.identifier, for: indexPath) as! DeliveryTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
