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
    
    var loadNum = 1
    var loadImg = false
    var cellHeight: CGFloat = 500
    
    // 购物车数量
    var cartNum = 0 {
        didSet {
            debugPrints("购物车数量---\(cartNum)")
            if cartNum > 0 {
                buyView.caiLanBtn.pp.moveBadge(x: -15, y: 10)
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
            
            isNetwork = true
            
            // 库存不够的时候 提示用户
            if goodsDetailInfo.stock <= 0 {
                buyView.buyBtn.alpha = 0.5
                buyView.buyBtn.isEnabled = false
                buyView.buyBtn.setTitle("已售罄", for: .normal)
                
                
                buyView.cartBtn.alpha = 0.5
                buyView.cartBtn.isEnabled = false
                buyView.cartBtn.setTitle("备货中0.0", for: .normal)
            }
            
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchShopingCartList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityVIew.center = view.center
    }
    
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
        
        // 立即购买
        buyView.buyBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.goodsInfoSelected(type: 1)
        }).disposed(by: rx.disposeBag)
        
        // 加入购物车
        buyView.cartBtn.rx.tap.subscribe(onNext: { (_) in
            self.goodsInfoSelected(type: 2)
        }).disposed(by: rx.disposeBag)
        
        buyView.caiLanBtn.rx.tap.subscribe(onNext: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name.goodsDetailCartClicked, object: nil)
            self.tabBarController?.selectedIndex = 2
            self.navigationController?.popToRootViewController(animated: false)
        }).disposed(by: rx.disposeBag)
        
        reachablitity.reachreplay.asObserver().subscribe(onNext: { [weak self] (flag) in
            guard let _ = self else { return }
            debugPrints("当前网络状态---\(flag)")
        }).disposed(by: rx.disposeBag)
        
        
        /// 不是会员 点击后 阔以直接点击打电话
        headerView.topView.memberViewBtn.rx.tap.subscribe(onNext: { (_) in
            
            debugPrint("用的vip表示---\(User.currentUser().isVip)")
            if User.currentUser().isVip == 0 {
                let tips = SelectTipsView()
                tips.btnClosure = { index in
                    if index  == 2 {
                        callUpWith(linkMan)
                    }
                }
            }
            
        }).disposed(by: rx.disposeBag)
        
    }
    
    func showNoNetwork() {
        view.id_empty = IDEmptyView.create().configStyle(netWorkStye)
        let _ = view.id_empty?.setOperatorAction { [weak self] in
            self?.fetchGoodsInfo()
        }
    }

    /// 商品选择规格
    func goodsInfoSelected(type: Int) {
        
        goodsInfoDemo.specificationView.goodsInfo = goodsDetailInfo
        goodsInfoDemo.show()
        
        goodsInfoDemo.specificationView.sureBtn.rx.tap.subscribe(onNext: { (_) in
           
            self.goodsInfoDemo.dismiss()
            
            let num = Int(self.goodsInfoDemo.specificationView.addView.numLab.text!)!
            
            // 立即购买
            if type == 1 {
                
                var goodsInfo = CartGoodsInfo()
                goodsInfo.productid = self.goodsDetailInfo.id
                goodsInfo.quantity = num
                goodsInfo.productname = self.goodsDetailInfo.productName
                goodsInfo.marketprice = CGFloat(self.goodsDetailInfo.marketPrice)
                goodsInfo.sellprice = self.goodsDetailInfo.salePrice
                goodsInfo.focusImgUrl = self.goodsDetailInfo.focusImgUrl
                self.navigator.show(segue: Navigator.Scene.shoppingOrder(list: [goodsInfo]), sender: self)
            }
            
            // 加入购物车
            if type == 2 {
                
                debugPrints("购物的数量为---\(num)")
                self.addToCart(num: num)
            }
            
        }).disposed(by: rx.disposeBag)
        
    }
    
    /// 加入购物车
    func addToCart(num: Int) {
        
        let productLists: [[String: Any]] = [["productid": goodsDetailInfo.id, "quantity": num]]
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
    
    lazy var goodsInfoDemo = SpecificationViewController()
    
    lazy var headerView: GoodsDetailHeaderView = {
        let view = GoodsDetailHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenW+320))
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
            
            MBProgressHUD.showError(error)
            self.activityVIew.stopAnimating()
            self.navigationController?.navigationBar.tintColor = UIColor.black
            
            debugPrints("获取商品信息出错---\(error)")
            //https://smartfarm-1257690229.cos.ap-shanghai.myqcloud.com/Image/Product/Detail/%E6%89%8B%E5%B7%A5%E9%85%B1%E6%B2%B9.png
            //https://smartfarm-1257690229.cos.ap-shanghai.myqcloud.com/Image/Product/Detail/%E7%99%BD%E8%90%9D%E5%8D%9C.png
            //https://smartfarm-1257690229.cos.ap-shanghai.myqcloud.com/Image/Product/Detail\/%E5%AE%9D%E5%A1%94%E8%8F%9C%E8%8A%B1.png
        }
    }
    
}

extension GoodsDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoodsDetailImgTabCell.identifier, for: indexPath) as! GoodsDetailImgTabCell
        //self.configureCell(cell: cell, indexPath: indexPath)
        
        cell.imgView.kf.indicatorType = .activity
        
        let url = URL(string: goodsDetailInfo.detailImgUrl)
        
        // 图片加载失败后在重新尝试一次
        if !self.loadImg && self.loadNum <= 2 {
            
            cell.imgView.kf.setImage(with: url, completionHandler: { (result) in
                // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
                switch result {
                case .success(let value):
                    
                    self.loadImg = true
                    self.cellHeight = value.image.size.height/value.image.size.width*kScreenW
                    
                    mainQueue {
                        self.tableView.reloadData()
                    }
                    
                    // The image was set to image view:
                    // From where the image was retrieved:
                    // - .none - Just downloaded.
                    // - .memory - Got from memory cache.
                    // - .disk - Got from disk cache.
                    // The source object which contains information like `url`.
                    debugPrint("缓存的类型---\(value.image)---\(value.cacheType)---\(value.source)")

                case .failure(let error):
                    print(error) // The error happens
                    self.loadImg = false
                    self.loadNum += 1
                    mainQueue {
                        self.tableView.reloadData()
                    }
                }
            })
        }

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
            downLoadImg(imgUrl: url, cell: cell)
        }
    }
    
    func downLoadImg(imgUrl: String, cell: GoodsDetailImgTabCell) {
        
        guard let url = URL(string: imgUrl) else {
            debugPrints("商品详情图片url不存在-----")
            cell.activity.stopAnimating()
            return
        }
        
        let downloader = ImageDownloader.default
        
        downloader.downloadImage(with: url, options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1))], progressBlock: nil) { (result)    in
            
            switch result {
                
            case .success(let value):
                debugPrints("商品详情页的图片下载成功---\(value.image)")
                ImageCache.default.store(value.image, original: value.originalData, forKey: imgUrl, options: KingfisherParsedOptionsInfo([KingfisherOptionsInfoItem.transition(ImageTransition.fade(1))]), toDisk: true, completionHandler: { (result) in
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
       
//        let url = goodsDetailInfo.detailImgUrl
//        let cachedImg = ImageCache.default.retrieveImageInMemoryCache(forKey: url)
//
//        if let img = cachedImg {
//            let imgH = img.size.height/img.size.width*kScreenW
//            debugPrints("返回图片的高度---\(imgH)")
//            return imgH
//        }else {
//            return 500
//        }
        
        return cellHeight
    }
    
}

extension GoodsDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offset = scrollView.contentOffset.y
        
        if offset < 0 {
            //let totalOffset: CGFloat = GoodsDetailBannerH
            //self.headerView.bannerView.frame = CGRect(x: 0, y: offset/2, width: kScreenW, height: totalOffset)
        }else {
            let totalOffset: CGFloat = kScreenW - abs(offset/2)
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

