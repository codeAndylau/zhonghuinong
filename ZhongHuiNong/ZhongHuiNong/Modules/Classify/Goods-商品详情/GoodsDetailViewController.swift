//
//  GoodsDetailViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/20.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class GoodsDetailViewController: ViewController {

    // MARK: - Property
    
    override func makeUI() {
        super.makeUI()

        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.view.insertSubview(barView, belowSubview: navigationController!.navigationBar)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarView)
        
        view.backgroundColor = Color.backdropColor
        view.addSubview(tableView)
        
        view.addSubview(buyView)
        
        statusBarStyle.accept(true)

    }

    override func bindViewModel() {
        super.bindViewModel()
        extendedLayoutIncludesOpaqueBars = true
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        rightBarView.homeBtn.rx.tap.subscribe(onNext: { (_) in
            debugPrints("点击了home")
        }).disposed(by: rx.disposeBag)
        
        rightBarView.shareBtn.rx.tap.subscribe(onNext: { (_) in
            debugPrints("点击了分享")
        }).disposed(by: rx.disposeBag)
    }
    
    // MARK: - Lazy
    lazy var buyView = GoodsDetailBuyView.loadView()
    lazy var rightBarView = GoodsDetailRightView.loadView()
    
    lazy var headerView: GoodsDetailHeaderView = {
        let view = GoodsDetailHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: GoodsDetailHeaderH))
        //view.bannerView.bannerArray.accept(["goods_tuijian_1","goods_tuijian_2"])
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var barView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kNavBarH))
        view.backgroundColor = UIColor.white
        view.alpha = 0
        return view
    }()

    lazy var tableView: TableView = {

        let view = TableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-kBottomViewH), style: .plain)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.tableHeaderView = headerView
        view.showsVerticalScrollIndicator = false
        view.register(DeliveryTabCell.self, forCellReuseIdentifier: DeliveryTabCell.identifier)
        return view
    }()
    

    
    // MARK: - Action
 
}

extension GoodsDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryTabCell.identifier, for: indexPath) as! DeliveryTabCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}

extension GoodsDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offset = scrollView.contentOffset.y
        
        if offset < 0 {
            //let totalOffset: CGFloat = GoodsDetailBannerH
            //self.headerView.bannerView.frame = CGRect(x: 0, y: offset/2, width: kScreenW, height: totalOffset)
        }else {
            let totalOffset: CGFloat = GoodsDetailBannerH - abs(offset/2)
            self.headerView.bannerView.frame = CGRect(x: 0, y: offset/2, width: kScreenW, height: totalOffset)
        }
        
        var delta =  offset / kNavBarH
        delta = CGFloat.maximum(delta, 0)
        barView.alpha = CGFloat.minimum(delta, 1)
        
        navigationItem.title =  delta > 0.8 ? "商品详情" : ""
        navigationController?.navigationBar.tintColor =  delta > 0.8 ? UIColor.black : UIColor.white
        delta > 0.8 ? statusBarStyle.accept(false) : statusBarStyle.accept(true)
    }
}
