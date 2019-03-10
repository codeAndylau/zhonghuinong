//
//  VegetableTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/13.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class VegetableTabCell: TableViewCell, TabReuseIdentifier, UITableViewDataSource, UITableViewDelegate {

    var goodsList: [CartGoodsInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let contView = View()
    let tableView = TableView()
    let headerView = VegetableTabCellHeaderView.loadView()
    let footerView = VegetableTabCellFooterView.loadView()
    let expressView = VegetableTabCellFooterView.loadView().then { (view) in
        view.lineView.isHidden = true
        view.titleLab.text = "配送费"
        view.timeLab.text = "会员免运费"
        // 配送-运费-会员免运费
    }
    
    override func makeUI() {
        super.makeUI()
        
        backgroundColor = Color.backdropColor
        tableView.backgroundColor = UIColor.orange
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(VegetableTabSubCell.self, forCellReuseIdentifier: VegetableTabSubCell.identifier)
        addSubview(contView)
        
        contView.addSubview(tableView)
        contView.addSubview(headerView)
        contView.addSubview(footerView)
        contView.addSubview(expressView)
    }

    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.top.equalTo(7)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-7)
        }
        
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(footerView.snp.top)
        }
        
        footerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(expressView.snp.top)
            make.height.equalTo(44)
        }
        
        expressView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // shadowCode
        contView.backgroundColor = Color.whiteColor
        contView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor
        contView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contView.layer.shadowOpacity = 1
        contView.layer.shadowRadius = 6
        contView.layer.cornerRadius = 12
    }
    
    // MARK: - Tab
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VegetableTabSubCell.identifier, for: indexPath) as! VegetableTabSubCell
        cell.selectionStyle = .none
        cell.goodsInfo = goodsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


class VegetableTabSubCell: TableViewCell, TabReuseIdentifier {
    
    var goodsInfo: CartGoodsInfo = CartGoodsInfo() {
        didSet {
            leftImg.lc_setImage(with: goodsInfo.focusImgUrl)
            titleLab.text = goodsInfo.productname
            numLab.text = "x\(goodsInfo.quantity)"
            priceLab.text = "\(goodsInfo.sellprice)"
            nonPriceLab.text = "\(goodsInfo.marketprice)"
        }
    }
    
    let leftImg = ImageView().then { (img) in
        img.image = UIImage(named: "basket_luobo")
        img.contentMode = .scaleAspectFit
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "新新鲜草莓500g/份"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let numLab = Label().then { (lab) in
        lab.text = "x1"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let priceLab = Label().then { (lab) in
        lab.text = "¥16.6"
        lab.textColor = UIColor.hexColor(0x1DD1A8)
        lab.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    let nonPriceLab = Label().then { (lab) in
        lab.text = "¥46.6"
        lab.textColor = UIColor.hexColor(0xB1B1B1)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(leftImg)
        addSubview(titleLab)
        addSubview(numLab)
        addSubview(priceLab)
        addSubview(nonPriceLab)
    }
    
    override func updateUI() {
        super.updateUI()
        
        leftImg.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(14)
            make.centerY.equalTo(self)
            make.width.height.equalTo(44)
        }
        
        priceLab.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
        }
        
        nonPriceLab.snp.makeConstraints { (make) in
            make.right.equalTo(priceLab.snp.right)
            make.top.equalTo(priceLab.snp.bottom)
        }

        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(leftImg.snp.right).offset(8)
            make.top.equalTo(self).offset(10)
            make.right.greaterThanOrEqualTo(numLab.snp.left).offset(15)
        }
        
        numLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(2)
        }
    }
    
}


class VegetableTabCellHeaderView: View {
    
    let titleLab = Label().then { (lab) in
        lab.text = "峻铭自营"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let arrowImg = ImageView().then { (img) in
        img.image = UIImage(named: "farm_arrowright_icon")
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xE5E5E5)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(arrowImg)
        addSubview(titleLab)
        addSubview(lineView)
    }
    
    
    override func updateUI() {
        super.updateUI()
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.centerY.equalTo(self)
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right).offset(6)
            make.centerY.equalTo(self)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
    }
    
    /// - Public methods
    class func loadView() -> VegetableTabCellHeaderView {
        let view = VegetableTabCellHeaderView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
}

class VegetableTabCellFooterView: View {

    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xE5E5E5)
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "配送时间"
        lab.textColor = UIColor.hexColor(0x4A4A4A)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let timeLab = Label().then { (lab) in
        lab.text = "尽快配送(预计2月4日送达)"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let arrowImg = ImageView().then { (img) in
        img.image = UIImage(named: "farm_add")
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(lineView)
        addSubview(titleLab)
        addSubview(timeLab)
        //addSubview(arrowImg)
    }
    
    
    override func updateUI() {
        super.updateUI()
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.height.equalTo(0.5)
            make.top.equalToSuperview()
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(14)
            make.centerY.equalTo(self)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
        }
        
        //        arrowImg.snp.makeConstraints { (make) in
        //            make.right.equalTo(-13)
        //            make.centerY.equalTo(self)
        //        }
    }
    
    /// - Public methods
    class func loadView() -> VegetableTabCellFooterView {
        let view = VegetableTabCellFooterView()
        view.backgroundColor = UIColor.clear
        return view
    }
}
