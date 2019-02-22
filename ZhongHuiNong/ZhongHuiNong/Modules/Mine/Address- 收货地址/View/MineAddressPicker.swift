//
//  MineAddressPicker.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

enum TableViewType: Int { case province = 100, city = 200, distrcit = 300, town = 400 }

fileprivate let provinceCellId = "provinceCell"
fileprivate let cityCellId = "cityCell"
fileprivate let districtCellId = "districtCell"
fileprivate let townCellId = "townCellId"

class MineAddressPicker: View {
    
    let topView = View().then { (view) in
        view.backgroundColor = Color.backdropColor
    }
    
    let scrollView = UIScrollView().then { (view) in
        view.backgroundColor = UIColor.orange
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "所在区域"
        lab.textColor = UIColor.black
        lab.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    let provinceButton = Button().then { (btn) in
        btn.setTitle("请选择", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x666666), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
    let cityButton = Button().then { (btn) in
        btn.setTitle("请选择", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x666666), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
    let districtButton = Button().then { (btn) in
        btn.setTitle("请选择", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x666666), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
    let townButton = Button().then { (btn) in
        btn.setTitle("请选择", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x666666), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
    // MARK: - Property
    var buttons: [UIButton] = []
    
    var province_tb: UITableView?
    var city_tb: UITableView?
    var district_tb: UITableView?
    var town_tb: UITableView?
    
    var provinces: [String] = []
    var cities: [String] = []
    var districts: [String] = []
    var towns: [String] = []
    
    var provinceIndexPath: IndexPath?
    var cityIndexPath: IndexPath?
    var districtIndexPath: IndexPath?
    var townIndexPath: IndexPath?
    
    var sel_province: String = "" {
        didSet {
    //            provinceButton.setTitle(sel_province, for: UIControl.State.normal)
    //            cityButton.setTitle("请选择", for: UIControl.State.normal)
    //            districtButton.setTitle(nil, for: UIControl.State.normal)
        }
    }
    
    var sel_city: String = "" {
        didSet {
    //            cityButton.setTitle(sel_city, for: UIControl.State.normal)
    //            districtButton.setTitle("请选择", for: UIControl.State.normal)
        }
    }
    
    var sel_district: String = "" {
        didSet {
            //            districtButton.setTitle(sel_district, for: UIControl.State.normal)
        }
    }
    
    var sel_town: String = "" {
        didSet {
            //            districtButton.setTitle(sel_district, for: UIControl.State.normal)
        }
    }

    typealias AreaAction = ((_ province: String, _ city: String, _ district: String, _ town: String) -> Void)?
    
    var selectedAreaCompleted: AreaAction
    
    override func makeUI() {
        super.makeUI()
        addSubview(topView)
        addSubview(scrollView)
        topView.addSubview(titleLab)
        topView.addSubview(provinceButton)
        topView.addSubview(cityButton)
        topView.addSubview(districtButton)
        topView.addSubview(townButton)
        setupTableView()
    }
    
    override func updateUI() {
        super.updateUI()
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(70)
        }
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.bottom.right.equalTo(self)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
        }
        
        provinceButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview()
        }
        
        cityButton.snp.makeConstraints { (make) in
            make.left.equalTo(provinceButton.snp.right)
            make.bottom.equalToSuperview()
        }
        
        districtButton.snp.makeConstraints { (make) in
            make.left.equalTo(cityButton.snp.right)
            make.bottom.equalToSuperview()
        }
        
        townButton.snp.makeConstraints { (make) in
            make.left.equalTo(districtButton.snp.right)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupTableView() {
        
        scrollView.delegate = self
        
        province_tb = factoryTableView(type: .province, cellIdentifier: provinceCellId)
        scrollView.addSubview(province_tb!)
        
        city_tb = factoryTableView(type: .city, cellIdentifier: cityCellId)
        scrollView.addSubview(city_tb!)
        
        district_tb = factoryTableView(type: .distrcit, cellIdentifier: districtCellId)
        scrollView.addSubview(district_tb!)
        
        town_tb = factoryTableView(type: .town, cellIdentifier: townCellId)
        scrollView.addSubview(town_tb!)
    }
    
    
    /// Public method
    class func loadView() -> MineAddressPicker {
        let view = MineAddressPicker(frame: CGRect(x: 0, y: 300, width: kScreenW, height: kScreenH-300))
        let corners: UIRectCorner = [.topLeft, .topRight]
        view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }
    
}

extension MineAddressPicker {
    
    var scrollViewHeight: CGFloat { return kScreenH-370}
    var tbFrame: CGRect {  return CGRect(x: 0, y: 0, width: kScreenW, height: scrollViewHeight) }
    
    func factoryTableView(type: TableViewType, cellIdentifier: String) -> UITableView {
        
        let tb = UITableView(frame: tbFrame, style: UITableView.Style.plain)
        tb.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tb.separatorStyle = UITableViewCell.SeparatorStyle.none
        tb.tableHeaderView = UIView()
        tb.tableFooterView = UIView()
        tb.tag = type.rawValue
        tb.dataSource = self
        tb.delegate = self
        tb.rowHeight = 44
        
        var frame = tb.frame
        switch type {
        case .province: frame.origin.x = 0
        case .city: frame.origin.x = kScreenW
        case .distrcit: frame.origin.x = kScreenW * 2
        case .town: frame.origin.x = kScreenW * 3
        }
        tb.frame = frame
        return tb
    }
}

extension MineAddressPicker: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = TableViewType(rawValue: tableView.tag)!
        switch type {
        case .province:
            return 5 //provinces.count
        case .city:
            return 7 //cities.count
        case .distrcit:
            return 9 //districts.count
        case .town:
            return 3 //towns.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = TableViewType(rawValue: tableView.tag)!
        switch type {
        case .province:
            let cell = tableView.dequeueReusableCell(withIdentifier: provinceCellId, for: indexPath)
            return cell
        case .city:
            let cell = tableView.dequeueReusableCell(withIdentifier: cityCellId, for: indexPath)
            return cell
        case .distrcit:
            let cell = tableView.dequeueReusableCell(withIdentifier: districtCellId, for: indexPath)
            return cell
        case .town:
            let cell = tableView.dequeueReusableCell(withIdentifier: townCellId, for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

extension MineAddressPicker: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if  scrollView.tag != 0 { return }
        _ = buttons.map { $0.isSelected = false }
        if scrollView.contentOffset.x == 0 { provinceButton.isSelected = true }
        if scrollView.contentOffset.x == kScreenW { cityButton.isSelected = true }
        if scrollView.contentOffset.x == kScreenW * 2  { districtButton.isSelected = true }
        if scrollView.contentOffset.x == kScreenW * 3  { townButton.isSelected = true }
    }
}
