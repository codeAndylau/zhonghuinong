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
    var isSelected = true
    
    override func makeUI() {
        super.makeUI()
        navigationItem.title = "配送选货"
        navigationItem.rightBarButtonItem = rightMsgItem
        view.addSubview(headerView)
        
        if isSelected {
            view.addSubview(tableView)
        }else {
            view.addSubview(collectionView)
            view.addSubview(commitVew)
        }

        if !isMember {
            view.addSubview(emptyView)
            emptyView.sureBtn.setTitle("去开通", for: .normal)
            emptyView.titleLab.text = "您暂不是会员用户，还没有该项服务"
        }
    }
    
    override func updateUI() {
        super.updateUI()
        
        if isSelected {
            tableView.snp.makeConstraints { (make) in
                make.top.equalTo(headerView.snp.bottom)
                make.left.bottom.right.equalToSuperview()
            }
        }else {
            collectionView.snp.makeConstraints { (make) in
                make.top.equalTo(headerView.snp.bottom)
                make.left.bottom.right.equalToSuperview()
            }
        }
        
        if !isMember {
            emptyView.snp.makeConstraints { (make) in
                make.top.equalTo(kNavBarH)
                make.left.bottom.right.equalTo(self.view)
            }
        }
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    
    // MAKR: - Lazy
    lazy var emptyView = CartEmptyView()
    lazy var headerView = DeliveryHeaderView.loadView()
    lazy var commitVew = DeliveryCommitOrderView.loadView()
    
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect.zero, style: .plain)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.register(MineTabCell.self, forCellReuseIdentifier: MineTabCell.identifier)
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DeliveryCollectionCell.self, forCellWithReuseIdentifier: DeliveryCollectionCell.identifier)
        return collectionView
    }()
    
    lazy var rightMsgItem = BarButtonItem(image: UIImage(named: "farm_message"), target: self, action: #selector(messageAction))
    
    // MARK: - Action
    
    @objc func editAction() {
        
    }
    
    @objc func messageAction() {
        
    }

}

extension DeliveryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineTabCell.identifier, for: indexPath) as! MineTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}

extension DeliveryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeliveryCollectionCell.identifier, for: indexPath) as! DeliveryCollectionCell
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
        return .zero
    }
}
