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

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.view.insertSubview(barView, belowSubview: navigationController!.navigationBar)
        
        view.backgroundColor = Color.backdropColor
        view.addSubview(tableView)
        
        view.addSubview(buyView)
        
        extendedLayoutIncludesOpaqueBars = true
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    override func updateUI() {
        super.updateUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    // MARK: - Lazy
    lazy var buyView = GoodsDetailBuyView.loadView()
    
    lazy var headerView: GoodsDetailHeaderView = {
        let view = GoodsDetailHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: GoodsDetailHeaderH))
        view.bannerView.bannerArray.accept(["goods_tuijian_1","goods_tuijian_2"])
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
        let view = TableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH), style: .plain)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.tableHeaderView = headerView
        view.showsVerticalScrollIndicator = false
        view.register(DeliveryTabCell.self, forCellReuseIdentifier: DeliveryTabCell.identifier)
        return view
    }()

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
        //获取偏移量
        let offset = scrollView.contentOffset.y

        
        // 视觉差效果，类似淘宝（下拉放大，上拉裁剪）
        if offset < 0 {
            //let totalOffset: CGFloat = GoodsDetailHeaderH + abs(offset)
            //self.headerView.bannerView.frame = CGRect(x: 0, y: offset/2, width: kScreenW, height: totalOffset)
        }else {
            let totalOffset: CGFloat = GoodsDetailBannerH - abs(offset) + abs(offset/2)
            self.headerView.bannerView.frame = CGRect(x: 0, y: offset/2, width: kScreenW, height: totalOffset)
        }
        
        // 导航栏背景透明度改变
        var delta =  offset / kNavBarH
        delta = CGFloat.maximum(delta, 0)
        barView.alpha = CGFloat.minimum(delta, 1)
        
        // 根据偏移量决定是否显示导航栏标题（上方图片快完全移出时才显示）
        navigationItem.title =  delta > 0.8 ? "商品详情" : ""
    }
}
