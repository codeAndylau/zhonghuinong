//
//  MineAddressPicker.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

enum TableViewType: Int { case province = 100, city = 200, distrcit = 300, town = 400 }

class MineAddressPicker: View {
    
    let topView = MineAddressTitleView().then { (view) in
        view.backgroundColor = Color.whiteColor
        view.provinceButton.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControl.Event.touchUpInside)
        view.cityButton.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControl.Event.touchUpInside)
        view.districtButton.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControl.Event.touchUpInside)
        view.townButton.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControl.Event.touchUpInside)
    }
    
    let scrollView = UIScrollView().then { (view) in
        view.backgroundColor = UIColor.white
        view.bounces = false
        view.isPagingEnabled = true
    }
    
    // MARK: - Property
    var buttons: [UIButton] = []
    
    var province_tb: UITableView?
    var city_tb: UITableView?
    var district_tb: UITableView?
    var town_tb: UITableView?
    
    var provinces: [Province] = []
    var cities: [City] = []
    var districts: [District] = []
    var towns: [String] = []
    
    var provinceIndexPath: IndexPath?
    var cityIndexPath: IndexPath?
    var districtIndexPath: IndexPath?
    var townIndexPath: IndexPath?
    
    var sel_province: String = "" {
        didSet {
            topView.provinceButton.setTitle(sel_province, for: UIControl.State.normal)
            topView.cityButton.setTitle("请选择", for: UIControl.State.normal)
            topView.districtButton.setTitle("", for: UIControl.State.normal)
            topView.townButton.setTitle("", for: UIControl.State.normal)
        }
    }
    
    var sel_city: String = "" {
        didSet {
            topView.cityButton.setTitle(sel_city, for: UIControl.State.normal)
            topView.districtButton.setTitle("请选择", for: UIControl.State.normal)
            topView.townButton.setTitle("", for: UIControl.State.normal)
        }
    }
    
    var sel_district: String = "" {
        didSet {
            topView.districtButton.setTitle(sel_district, for: UIControl.State.normal)
            topView.townButton.setTitle("请选择", for: UIControl.State.normal)
        }
    }
    
    var sel_town: String = "" {
        didSet {
            topView.townButton.setTitle(sel_town, for: UIControl.State.normal)
        }
    }

    typealias AreaAction = ((_ province: String, _ city: String, _ district: String, _ town: String) -> Void)?
    var selectedAreaCompleted: AreaAction
    
    override func makeUI() {
        super.makeUI()
        addSubview(topView)
        addSubview(scrollView)
        setupTableView()
        setupButtons()
        loadData()
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
    }
    
    func setupTableView() {
        
        scrollView.delegate = self
        
        province_tb = factoryTableView(type: .province)
        scrollView.addSubview(province_tb!)
        
        city_tb = factoryTableView(type: .city)
        scrollView.addSubview(city_tb!)
        
        district_tb = factoryTableView(type: .distrcit)
        scrollView.addSubview(district_tb!)
        
        town_tb = factoryTableView(type: .town)
        scrollView.addSubview(town_tb!)
    }
    
    func setupButtons() {
        topView.provinceButton.isSelected = true
        buttons = [topView.provinceButton, topView.cityButton, topView.districtButton, topView.townButton]
        _ = buttons.map {
            $0.setTitleColor(UIColor.hexColor(0x999999), for: UIControl.State.normal)
            $0.setTitleColor(UIColor.hexColor(0x1DD1A8), for: UIControl.State.selected)
        }
    }
    
    func loadData() {
        let path = Bundle.main.path(forResource: "Area", ofType: "plist")!
        let rootArray = NSArray(contentsOfFile: path)!
        rootArray.enumerateObjects { (obj, index, stop) in
            let value = JSON(obj)
            if let model = Mapper<Province>().map(JSONObject: value.object) {
                provinces.append(model)
            }
        }
        debugPrints("省份--\(provinces.count)个")
        province_tb?.reloadData()
    }
    
    // MARK: - Action
    
    @objc func buttonAction(sender: Button) {
        
        debugPrints("出现bug了--\(String(describing: sender.titleLabel?.text))")
        
        guard sender.titleLabel?.text != nil && sender.titleLabel?.text != "" else {
            debugPrints("出现bug了--mmp")
            return
        }
        
        let type = TableViewType(rawValue: sender.tag)
        switch type! {
        case .province: scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case .city: scrollView.setContentOffset(CGPoint(x: kScreenW, y: 0), animated: true)
        case .distrcit: scrollView.setContentOffset(CGPoint(x: kScreenW * 2, y: 0), animated: true)
        case .town: scrollView.setContentOffset(CGPoint(x: kScreenW * 3, y: 0), animated: true)
        }
    }
    
    /// Public method
    class func loadView() -> MineAddressPicker {
        let view = MineAddressPicker(frame: CGRect(x: 0, y: kScreenH*0.25, width: kScreenW, height: kScreenH*0.75))
        let corners: UIRectCorner = [.topLeft, .topRight]
        view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }
    
}

extension MineAddressPicker {
    
    var scrollViewHeight: CGFloat { return kScreenH*0.75-70}
    var tbFrame: CGRect {  return CGRect(x: 0, y: 0, width: kScreenW, height: scrollViewHeight) }
    
    func factoryTableView(type: TableViewType) -> UITableView {
        
        let tb = UITableView(frame: tbFrame, style: UITableView.Style.plain)
        tb.register(MineAreaTabCell.self, forCellReuseIdentifier: MineAreaTabCell.identifier)
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
            return provinces.count
        case .city:
            return cities.count
        case .distrcit:
            return districts.count
        case .town:
            return towns.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MineAreaTabCell.identifier, for: indexPath) as! MineAreaTabCell
        
        let type = TableViewType(rawValue: tableView.tag)!
        switch type {
        case .province:
            cell.titleLab.text = provinces[indexPath.row].state
            cell.isSelect = indexPath == provinceIndexPath
        case .city:
            cell.titleLab.text = cities[indexPath.row].city
            cell.isSelect = indexPath == cityIndexPath
        case .distrcit:
            cell.titleLab.text = districts[indexPath.row].county
            cell.isSelect = indexPath == districtIndexPath
        case .town:
            cell.titleLab.text = towns[indexPath.row]
            cell.isSelect = indexPath == townIndexPath
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let type = TableViewType(rawValue: tableView.tag)!
        
        switch type {
        case .province:
            debugPrints("省")
            
            /// 当第二次点击的时候 清零处理
            if let provinceIndex = provinceIndexPath {
                let cell = tableView.cellForRow(at: provinceIndex) as? MineAreaTabCell
                cell?.isSelect = false
                if provinceIndex != indexPath {
                    cityIndexPath = nil
                    districtIndexPath = nil
                    townIndexPath = nil
                }
            }
            
            provinceIndexPath = indexPath
            sel_province = provinces[indexPath.row].state
            cities = provinces[indexPath.row].cities
            
            let cell = tableView.cellForRow(at: indexPath) as! MineAreaTabCell
            cell.isSelect = true
            
            scrollView.contentSize = CGSize(width: kScreenW*2, height: scrollViewHeight)
            scrollView.setContentOffset(CGPoint(x: kScreenW, y: 0), animated: true)
            city_tb?.reloadData()
            
        case .city:
            debugPrints("市")
            
            if let cityIndex = cityIndexPath {
                let cell = tableView.cellForRow(at: cityIndex) as? MineAreaTabCell
                cell?.isSelect = false
                if cityIndex != indexPath {
                    districtIndexPath = nil
                    townIndexPath = nil
                }
            }
            
            cityIndexPath = indexPath
            sel_city = cities[indexPath.row].city
            districts = cities[indexPath.row].areas
            
            let cell = tableView.cellForRow(at: indexPath) as! MineAreaTabCell
            cell.isSelect = true

            if districts.count > 0 {
                scrollView.contentSize = CGSize(width: kScreenW*3, height: scrollViewHeight)
                scrollView.setContentOffset(CGPoint(x: kScreenW*2, y: 0), animated: true)
                district_tb?.reloadData()
            }else {
                selectedAreaCompleted?(sel_province, sel_city, sel_district, sel_town)
                // FIXME: - dismiss
            }
            
        case .distrcit:
            debugPrints("区")
            
            if let districtIndex = districtIndexPath {
                let cell = tableView.cellForRow(at: districtIndex) as? MineAreaTabCell
                cell?.isSelect = false
                if districtIndex != indexPath {
                    townIndexPath = nil
                }
            }
            
            districtIndexPath = indexPath
            sel_district = districts[indexPath.row].county
            towns = districts[indexPath.row].streets
            
            let cell = tableView.cellForRow(at: indexPath) as! MineAreaTabCell
            cell.isSelect = true
            
            if towns.count > 0 {
                scrollView.contentSize = CGSize(width: kScreenW*4, height: scrollViewHeight)
                town_tb?.reloadData()
                scrollView.setContentOffset(CGPoint(x: kScreenW*3, y: 0), animated: true)
            }else {
                selectedAreaCompleted?(sel_province, sel_city, sel_district, sel_town)
                // FIXME: - dismiss
            }
            
        case .town:
            debugPrints("街道")
            
            if let townIndex = townIndexPath {
                let cell = tableView.cellForRow(at: townIndex) as? MineAreaTabCell
                cell?.isSelect = false
            }
            
            townIndexPath = indexPath
            sel_town = towns[indexPath.row]
            
            let cell = tableView.cellForRow(at: indexPath) as! MineAreaTabCell
            cell.isSelect = true
            
            selectedAreaCompleted?(sel_province, sel_city, sel_district, sel_town)
            // FIXME: - dismiss
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

extension MineAddressPicker: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x
        if  scrollView.tag != 0 { return }
        _ = buttons.map { $0.isSelected = false }
        
        if offsetX == 0 { topView.provinceButton.isSelected = true }
        if offsetX == kScreenW { topView.cityButton.isSelected = true }
        if offsetX == kScreenW * 2  { topView.districtButton.isSelected = true }
        if offsetX == kScreenW * 3  { topView.townButton.isSelected = true }
    }
}
