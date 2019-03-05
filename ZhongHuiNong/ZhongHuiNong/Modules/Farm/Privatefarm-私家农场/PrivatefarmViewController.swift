//
//  PrivatefarmViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 私家农场
class PrivatefarmViewController: ViewController {

    lazy var dataArray = [
        PrivatefarmCropsModel(color: 0x0BC7D8, title: "水份", total: 35.6, unit: "ppi", start: "0%", end: 100),
        PrivatefarmCropsModel(color: 0xFF7477, title: "温度", total: 18.8, unit: "℃", start: "0℃", end: 60),
        PrivatefarmCropsModel(color: 0x16C6A3, title: "二氧化碳", total: 524, unit: "ppm", start: "350ppm", end: 1000),
        PrivatefarmCropsModel(color: 0xF6C93B, title: "光照", total: 2799, unit: "lux", start: "0lux", end: 10000)
    ]
    
    var isValue = false
    var farmLand: FarmLand = FarmLand()
    var sensorData: FarmSensordata = FarmSensordata()
    
    override func makeUI() {
        super.makeUI()
        
         if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        view.addSubview(loadView)
    }

    override func bindViewModel() {
        super.bindViewModel()
        
        headerView.playBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.playerView.playVideoWith(self.farmLand.cameraUrl, containView: self.headerView.videoImg)
        }).disposed(by: rx.disposeBag)
        
       fetchFarmLand()

    }
    
    func fetchFarmLand() {
        var p = [String: Any]()
        p["userid"] = 3261 //User.userId()
        
        debugPrints("私家农场参数---\(p)")
        
        /// 请求农场的信息
        WebAPITool.requestModel(WebAPI.farmLand(p), model: FarmLand.self, complete: { (model) in
            self.farmLand = model
            self.fetchSensorData(model.did)
        }) { (error) in
            ZYToast.showCenterWithText(text: error)
        }
    }
    
    func fetchSensorData(_ did: String) {
        var p = [String: Any]()
        p["did"] = did
        
        /// 请求传感器信息
        WebAPITool.requestModel(WebAPI.farmSensordata(p), model: FarmSensordata.self, complete: { (model) in
            self.isValue = true
            self.sensorData = model
            
            DispatchQueue.main.async {
                UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
                    self.loadView.imageView.alpha = 0.1
                    self.loadView.alpha = 0.1
                }) { (_) in
                    self.loadView.removeFromSuperview()
                }
                self.navigationItem.titleView = self.titleView
                self.tableView.tableHeaderView = self.headerView
                self.view.addSubview(self.tableView)
                self.tableView.reloadData()
            }
            
        }) { (error) in
            ZYToast.showCenterWithText(text: "获取数据失败!")
        }
    }
    
    // MARK: - Lazy
    lazy var loadView = FlashLoadingView()
    lazy var titleView = PrivatefarmTitleView.loadView()
    lazy var headerView = PrivatefarmHeaderView.loadView()
    
    lazy var playerView: EZPlayerView = {
        let player = EZPlayerView(frame: CGRect.zero)
        return player
    }()

    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH), style: .plain)
        view.backgroundColor = UIColor.white
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.register(PrivatefarmTabCell.self, forCellReuseIdentifier: PrivatefarmTabCell.identifier)
        view.uempty = UEmptyView(verticalOffset: -kNavBarH, tapClosure: { [weak self] in
            self?.fetchFarmLand()
        })
        return view
    }()

}

extension PrivatefarmViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isValue ? dataArray.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PrivatefarmTabCell.identifier, for: indexPath) as! PrivatefarmTabCell
        cell.model = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
