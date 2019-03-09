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

class GoodsDetailViewController: ViewController {

    // MARK: - Property
    
    var goodId: Int = defaultId
    var goodsDetailInfo: GoodsDetailInfo = GoodsDetailInfo() {
        didSet {
            fadeInOnDisplay {
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarView)
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
    }
    
    // MARK: - Lazy
    
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
        view.estimatedRowHeight = 100
        view.rowHeight = UITableView.automaticDimension
        
        return view
    }()
    

    // MARK: - Action

    func fetchGoodsInfo() {
        WebAPITool.requestModelWithData(WebAPI.goodsDetail(goodId), model: GoodsDetailInfo.self, complete: { [weak self] (info) in
            debugPrints("商品详情信息---\(info)")
            guard let self = self else { return }
            self.goodsDetailInfo = info
        }) { (error) in
            debugPrints("获取商品信息出错---\(error)")
        }
    }
    
}

extension GoodsDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoodsDetailImgTabCell.identifier, for: indexPath) as! GoodsDetailImgTabCell
        let url = "https://smartfarm-1257690229.cos.ap-shanghai.myqcloud.com/Image/Product/Detail/%E4%B8%8A%E6%B5%B7%E9%9D%92.jpg"
        cell.imgView.lc_setImage(with: url)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let url = "https://smartfarm-1257690229.cos.ap-shanghai.myqcloud.com/Image/Product/Detail/%E4%B8%8A%E6%B5%B7%E9%9D%92.jpg"
        return calculteCellH(imgUrl: url)
    }
    
    func calculteCellH(imgUrl: String) -> CGFloat {
        
        var cellH: CGSize = CGSize.zero
        let cachedImg = ImageCache.default.retrieveImageInDiskCache(forKey: imgUrl)
        
        if let img = cachedImg {
            debugPrints("图片缓存的高度---\(img.size.height)")
            cellH = img.size
        }else {
            // 利用 Kingfisher 框架提供的功能下载图片
            let url = URL(string: imgUrl)!
            
            ImageDownloader.default.downloadImage(with: url, retrieveImageTask: nil, options: nil, progressBlock: nil) { (img, error, url, data) in
                guard img != nil else {return }
                ImageCache.default.store(img!, original: nil, forKey: imgUrl, processorIdentifier: "", cacheSerializer: DefaultCacheSerializer.default, toDisk: true, completionHandler: {
                    let cachedImg = ImageCache.default.retrieveImageInDiskCache(forKey: imgUrl)
                    if let img = cachedImg {
                        debugPrints("图片下载的高度---\(img.size.height)")
                        cellH = img.size
                    }
                })
            }
        }
        debugPrints("图片的缩放比例\(cellH.height/cellH.width*kScreenW)")
        return cellH.height/cellH.width*kScreenW
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
