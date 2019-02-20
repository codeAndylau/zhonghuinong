//
//  DeliveryViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 配送选货
class DeliveryViewController: ViewController {

    var isMember = true
    var isSelected = false
    
    var isDay2 = true
    var isDay5 = false
    
    var day2Array: [Int] = []
    var day5Array: [Int] = []
    
    override func makeUI() {
        super.makeUI()
        
        view.backgroundColor = UIColor.white
        view.addSubview(headerView)
        
        navigationItem.rightBarButtonItems = [rightMsgItem, rightRecordItem]
        
        if isSelected {
            navigationItem.title = "本周订单"
            view.addSubview(tableView)
            tableView.addSubview(headerView)
        }else {
            navigationItem.title = "配送选货"
            view.addSubview(collectionView)
            view.addSubview(commitVew)
            collectionView.addSubview(headerView)
        }

        if !isMember {
            view.addSubview(emptyView)
            emptyView.sureBtn.setTitle("去开通", for: .normal)
            emptyView.titleLab.text = "您暂不是会员用户，还没有该项服务"
            emptyView.snp.makeConstraints { (make) in
                make.top.equalTo(kNavBarH)
                make.left.bottom.right.equalTo(self.view)
            }
        }
        
        headerView.addressView.modifyBtn.rx.tap.subscribe(onNext: { (_) in
            let addressVC = DeliveryAddressViewController()
            addressVC.show()
        }).disposed(by: rx.disposeBag)
        
        headerView.dateView.day2Btn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.isDay2 = true
            self.isDay5 = false
            self.headerView.dateView.day2Height()
        }).disposed(by: rx.disposeBag)
        
        headerView.dateView.day5Btn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.isDay2 = false
            self.isDay5 = true
            self.headerView.dateView.day5Height()
        }).disposed(by: rx.disposeBag)
        
        
        commitVew.orderBtn.rx.tap.subscribe(onNext: {  [weak self] (_) in
            guard let self = self else {
                debugPrints("没有self吗,zz")
                return
            }
            guard self.day2Array.count != 0 else {
                ZYToast.showCenterWithText(text: "请选择周二配送菜单")
                return
            }
            
            guard self.day5Array.count != 0 else {
                ZYToast.showCenterWithText(text: "请选择周五配送菜单")
                return
            }
            
            debugPrints("周二菜单---\(self.day2Array)")
            debugPrints("周五菜单---\(self.day5Array)")
            
            let orderVC = DeliveryOrderViewController()
            orderVC.show()
            
        }).disposed(by: rx.disposeBag)
    }
    
    override func updateUI() {
        super.updateUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    
    // MAKR: - Lazy
    lazy var emptyView = CartEmptyView()
    lazy var headerView = DeliveryHeaderView.loadView()
    lazy var footerView = DeliveryFooterView.loadView()
    lazy var commitVew = DeliveryCommitOrderView.loadView()
    
    lazy var tableView: TableView = {
        let viewH = IPhone_X == true ? 56+kIndicatorH : 56
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH-viewH-15), style: .plain)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.tableFooterView = footerView
        view.showsVerticalScrollIndicator = false
        view.register(DeliveryTabCell.self, forCellReuseIdentifier: DeliveryTabCell.identifier)
        view.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let viewH = IPhone_X == true ? 56+kIndicatorH : 56
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH-viewH-15), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(DeliveryCollectionCell.self, forCellWithReuseIdentifier: DeliveryCollectionCell.identifier)
        return collectionView
    }()
    
    lazy var rightMsgItem = BarButtonItem(image: UIImage(named: "farm_message"), target: self, action: #selector(messageAction))
    lazy var rightRecordItem = BarButtonItem(image: UIImage(named: "farm_record"), target: self, action: #selector(recordAction))
    
    // MARK: - Action
    
    @objc func recordAction() {
        let recordVC = DeliveryOrderInfoViewController()
        self.navigationController?.pushViewController(recordVC, animated: true)
    }
    
    @objc func messageAction() {
        
    }

}

extension DeliveryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryTabCell.identifier, for: indexPath) as! DeliveryTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        headerView.frame = CGRect(x: 0, y: offsetY, width: kScreenW, height: 150)
    }
    
}

extension DeliveryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeliveryCollectionCell.identifier, for: indexPath) as! DeliveryCollectionCell
        
            cell.addView.addDidClosure = { [weak self] in

                guard let self = self else { return }
                
                if self.isDay2 {
                    self.day2Array.append(indexPath.row)
                }
                
                if self.isDay5 {
                    self.day5Array.append(indexPath.row)
                }
                
            }
            
            cell.addView.minusDidClosure = { [weak self] in
                
                guard let self = self else { return }
                
                if self.isDay2 {
                    self.day2Array.remove(at: indexPath.row)
                }
                if self.isDay5 {
                    self.day5Array.remove(at: indexPath.row)
                }
            }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let specificationVC = SpecificationViewController()
        specificationVC.show()
    }
    
    //定义每个Cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenW/3, height: kScreenW/3+80)
    }
    
    //定义每个Section的四边间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
    }
}
