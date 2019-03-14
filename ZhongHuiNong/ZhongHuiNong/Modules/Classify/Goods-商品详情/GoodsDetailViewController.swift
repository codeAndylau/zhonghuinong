//
//  GoodsDetailViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/20.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import Kingfisher
import Result
import PPBadgeViewSwift
import MBProgressHUD

class GoodsDetailViewController: ViewController {

    // MARK: - Property
    
    // 购物车数量
    var cartNum = 0 {
        didSet {
            debugPrints("购物车数量---\(cartNum)")
            if cartNum > 0 {
                buyView.caiLanBtn.pp.addBadge(number: cartNum)
                buyView.caiLanBtn.pp.setBadgeLabel { (lab) in
                    lab.backgroundColor = Color.theme1DD1A8
                }
            }
        }
    }
    
    var goodId: Int = defaultId
    var goodsDetailInfo: GoodsDetailInfo = GoodsDetailInfo() {
        didSet {
            fadeInOnDisplay {
                self.activityVIew.stopAnimating()
                self.tableView.alpha = 1
                self.headerView.goodsDetailInfo = self.goodsDetailInfo
                self.view.addSubview(self.tableView)
                self.view.addSubview(self.buyView)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Override
    override func makeUI() {
        super.makeUI()
        
        statusBarStyle.accept(true)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.view.insertSubview(barView, belowSubview: navigationController!.navigationBar)
        //navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarView)
        view.addSubview(activityVIew)
        activityVIew.startAnimating()
        fetchGoodsInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchShopingCartList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityVIew.center = view.center
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
        
        // 底部操作试图
        buyView.cartBtn.rx.tap.subscribe(onNext: { (_) in
            self.addToCart()
        }).disposed(by: rx.disposeBag)
        
        buyView.buyBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.bindingPhone()
        }).disposed(by: rx.disposeBag)
        
        buyView.caiLanBtn.rx.tap.subscribe(onNext: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name.goodsDetailCartClicked, object: nil)
            self.tabBarController?.selectedIndex = 2
            self.navigationController?.popToRootViewController(animated: false)
        }).disposed(by: rx.disposeBag)
        
    }
    
    func bindingPhone() {
        
        if User.hasUser() && User.currentUser().mobile != "" {
            buyCart()
        }else {
            navigator.show(segue: .bindingMobile, sender: self)
        }
    }
    
    func buyCart() {
        
        var goodsInfo = CartGoodsInfo()
        goodsInfo.productid = self.goodsDetailInfo.id
        goodsInfo.quantity = 1
        goodsInfo.productname = self.goodsDetailInfo.productName
        goodsInfo.marketprice = CGFloat(self.goodsDetailInfo.marketPrice)
        goodsInfo.sellprice = self.goodsDetailInfo.salePrice
        goodsInfo.focusImgUrl = self.goodsDetailInfo.focusImgUrl
        self.navigator.show(segue: Navigator.Scene.shoppingOrder(list: [goodsInfo]), sender: self)
        
    }
    
    /// 加入购物车
    func addToCart() {
        
        let productLists: [[String: Any]] = [["productid": goodsDetailInfo.id, "quantity": 1]]
        let userId = User.currentUser().userId
        
        debugPrints("加入购物车参数--\(productLists)---\(userId)")
        
        WebAPITool.request(WebAPI.addToCart(userId, productLists), complete: { (value) in
            debugPrints("购物车参数成功--\(value))")
            if value.boolValue {
                MBProgressHUD.showSuccess("加入购物车成功")
                self.cartNum += 1
            }else {
                MBProgressHUD.showError("加入购物车失败")
            }
        }) { (error) in
            debugPrints("购物车参数失败--\(error))")
        }
        
    }
    
    /// 获取购物车的数量
    func fetchShopingCartList() {
        
        guard User.hasUser() else {
            debugPrints("你还没有登录账号")
            return
        }
        
        var p = [String: Any]()
        p["userid"] = User.currentUser().userId
        
        WebAPITool.requestModelArrayWithData(WebAPI.fetchCart(p), model: CartGoodsInfo.self, complete: { [weak self] (list) in
            guard let self = self else { return }
            mainQueue {
                self.cartNum = list.count
            }
        }) { (error) in
             debugPrints("商品详情获取购物车数量出错---\(error)")
        }
        
    }
    
    // MARK: - Lazy
    lazy var activityVIew = UIActivityIndicatorView(style: .gray)
    lazy var buyView = GoodsDetailBuyView.loadView()
    lazy var rightBarView = GoodsDetailRightView.loadView()
    
    lazy var headerView: GoodsDetailHeaderView = {
        let view = GoodsDetailHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: GoodsDetailHeaderH))
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
        view.alpha = 0
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.tableHeaderView = headerView
        view.showsVerticalScrollIndicator = false
        view.register(GoodsDetailImgTabCell.self, forCellReuseIdentifier: GoodsDetailImgTabCell.identifier)
        return view
    }()
    

    // MARK: - Action

    func fetchGoodsInfo() {
        
        WebAPITool.requestModelWithData(WebAPI.goodsDetail(goodId), model: GoodsDetailInfo.self, complete: { [weak self] (info) in
            guard let self = self else { return }
            self.goodsDetailInfo = info
        }) { (error) in
            debugPrints("获取商品信息出错---\(error)")
        }
    }
    
}

extension GoodsDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodsDetailInfo.detailImgUrl != "" ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoodsDetailImgTabCell.identifier, for: indexPath) as! GoodsDetailImgTabCell
        self.configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: GoodsDetailImgTabCell, indexPath: IndexPath) {
        
        let url = goodsDetailInfo.detailImgUrl
        let cachedImg = ImageCache.default.retrieveImageInMemoryCache(forKey: url) // 缓存在内存中的 ，响应速度更快
        
        if let img = cachedImg {
            cell.activity.stopAnimating()
            cell.imgView.image = img
        }else {
            cell.activity.startAnimating()
            downLoadImg(imgUrl: url, indexPath: indexPath)
        }
    }
    
    func downLoadImg(imgUrl: String, indexPath: IndexPath) {
        
        guard let url = URL(string: imgUrl) else {
            debugPrints("商品详情图片url不存在-----")
            return
        }
        
        let downloader = ImageDownloader.default
        
        downloader.downloadImage(with: url, options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1))], progressBlock: nil) { (result)    in
            
            switch result {
                
            case .success(let value):
                debugPrints("商品详情页的图片下载成功---\(value.image)")
                ImageCache.default.store(value.image, forKey: imgUrl)
                ImageCache.default.store(value.image, original: value.originalData, forKey: imgUrl, options: KingfisherParsedOptionsInfo([KingfisherOptionsInfoItem.transition(ImageTransition.fade(1))]), toDisk: false, completionHandler: { (result) in
                    mainQueue {
                        self.tableView.reloadData()
                    }
                })
            case .failure(let error):
                debugPrints("商品详情页的图片下载失败---\(error)")
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        let url = goodsDetailInfo.detailImgUrl
        let cachedImg = ImageCache.default.retrieveImageInMemoryCache(forKey: url)
        
        if let img = cachedImg {
            let imgH = img.size.height/img.size.width*kScreenW
            debugPrints("返回图片的高度---\(imgH)")
            return imgH
        }else {
            return 500
        }
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

