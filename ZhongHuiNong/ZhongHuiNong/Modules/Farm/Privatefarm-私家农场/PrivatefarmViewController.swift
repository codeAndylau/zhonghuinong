//
//  PrivatefarmViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import MBProgressHUD

/// 私家农场
class PrivatefarmViewController: ViewController {

    var isValue = false
    
    lazy var dataArray = [
        PrivatefarmCropsModel(color: 0x0BC7D8, title: "水份", total: 35.6, unit: "ppi", start: "0%", end: 100),
        PrivatefarmCropsModel(color: 0xFF7477, title: "温度", total: 18.8, unit: "℃", start: "0℃", end: 60),
        PrivatefarmCropsModel(color: 0x16C6A3, title: "二氧化碳", total: 524, unit: "ppm", start: "350ppm", end: 1000),
        PrivatefarmCropsModel(color: 0xF6C93B, title: "光照", total: 2799, unit: "lux", start: "0lux", end: 10000)
    ]
    
    var farmLand: FarmLand = FarmLand() {
        didSet {
            titleView.titleLab.text = User.currentUser().username + "园地"
        }
    }
    
    var sensorData: FarmSensordata = FarmSensordata() {
        didSet {
            
            if sensorData.water == -1 {
                isValue = false
                self.tableView.reloadData()
            }else {
                dataArray[0].total = sensorData.water
                dataArray[1].total = sensorData.temperature
                dataArray[2].total = sensorData.cO2
                dataArray[3].total = sensorData.illumination
                
                isValue = true
                self.tableView.reloadData()
            }
        }
    }
    
    deinit {
        debugPrint("私家农场已经销毁")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        headerView.timer_js?.cancel()
        headerView.timer_js = nil
        
        headerView.timer_sf?.cancel()
        headerView.timer_sf = nil
        
        headerView.timer_sc?.cancel()
        headerView.timer_sc = nil
        
        headerView.timer_cc?.cancel()
        headerView.timer_cc = nil
    }
    
    override func makeUI() {
        super.makeUI()
        
         if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
        view.addSubview(loadView)
        navigationItem.titleView = titleView
        tableView.tableHeaderView = headerView
        view.addSubview(tableView)
        fetchFarmLand()
    }

    override func bindViewModel() {
        super.bindViewModel()
        
        headerView.playBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            
            guard let self = self else { return }
//            guard !self.farmLand.cameraUrl.isEmpty && self.farmLand.cameraUrl != "" else {
//                MBProgressHUD.showError("视频播放链接有误")
//                return
//            }
            //let url = self.farmLand.cameraUrl
            
            let url = "ezopen://open.ys7.com/691254818/1.hd.live"
            self.playerView.playVideoWith(url, containView: self.headerView.videoImg)
            
        }).disposed(by: rx.disposeBag)
        
        self.playerView.playStatus = { [weak self] flag in
            if flag {
                self?.headerView.playBtn.isHidden = true
                debugPrint("农场视频播放成功")
            }else {
                self?.headerView.playBtn.isHidden = true
                debugPrint("农场视频播放失败")
            }
        }
        
        headerView.jiaoshuiBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.farmWater()
        }).disposed(by: rx.disposeBag)
        
        headerView.shifeiBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.farmFertilize()
        }).disposed(by: rx.disposeBag)
        
        headerView.shachongBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.farmKillbug()
        }).disposed(by: rx.disposeBag)
        
        headerView.chucaoBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.headerView.startTimer(.chucao)
        }).disposed(by: rx.disposeBag)
        
    }
    
    func fetchFarmLand() {
        
        var p = [String: Any]()
        p["userid"] = User.currentUser().userId
        
        /// 请求农场的信息
        WebAPITool.requestModel(WebAPI.farmLand(p), model: FarmLand.self, complete: { [weak self] (model) in
            guard let self = self else { return }
            self.farmLand = model
            self.fetchSensorData(model.did)
        }) { (error) in
            debugPrints("请求农场的信息---\(error)")
        }
    }
    
    func fetchSensorData(_ did: String) {
        
        var p = [String: Any]()
        p["did"] = did
        
        /// 请求传感器信息
        WebAPITool.requestModel(WebAPI.farmSensordata(p), model: FarmSensordata.self, complete: { [weak self] (model) in
            guard let self = self else { return }
            self.sensorData = model
        }) { (error) in
            self.sensorData = FarmSensordata()
            debugPrints("请求传感器信息---\(error)")
            ZYToast.showCenterWithText(text: "获取传感器数据失败!")
        }
    }
    
    func farmWater() {
        var p = [String: Any]()
        p["did"] = farmLand.did
        HudHelper.showWaittingHUD(msg: "请求中...")
        WebAPITool.request(WebAPI.farmWater(p), complete: { [weak self] (value) in
            guard let self = self else { return }
            HudHelper.hideHUD()
            if value.boolValue {
                mainQueue {
                    self.headerView.startTimer(.jiaoshui)
                }
            }else {
                ZYToast.showCenterWithText(text: "设备故障或者不在线")
            }
        }) { (error) in
            ZYToast.showCenterWithText(text: error)
        }
    }
    
    func farmFertilize() {
        var p = [String: Any]()
        p["did"] = farmLand.did
        HudHelper.showWaittingHUD(msg: "请求中...")
        WebAPITool.request(WebAPI.farmFertilize(p), complete: { [weak self] (value) in
            guard let self = self else { return }
            HudHelper.hideHUD()
            if value.boolValue {
                mainQueue {
                    self.headerView.startTimer(.shifei)
                }
            }else {
               ZYToast.showCenterWithText(text: "设备故障或者不在线")
            }
        }) { (error) in
            ZYToast.showCenterWithText(text: error)
        }
    }
    
    func farmKillbug() {
        var p = [String: Any]()
        p["did"] = farmLand.did
        
        HudHelper.showWaittingHUD(msg: "请求中...")
        WebAPITool.request(WebAPI.farmKillbug(p), complete: { [weak self] (value) in
            guard let self = self else { return }
            HudHelper.hideHUD()
            if value.boolValue {
                mainQueue {
                    self.headerView.startTimer(.shachong)
                }
            }else {
                ZYToast.showCenterWithText(text: "设备故障或者不在线")
            }
            
        }) { (error) in
            ZYToast.showCenterWithText(text: error)
        }
    }
    
    // MARK: - Lazy
    lazy var loadView = LoadingView()
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
        return isValue == true ? dataArray.count : 0
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
