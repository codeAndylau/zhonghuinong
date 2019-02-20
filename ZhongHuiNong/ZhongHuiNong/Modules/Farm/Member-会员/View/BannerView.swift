//
//  BannerView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import TYCyclePagerView

class BannerView: UIView {

    var bannerArray = BehaviorRelay<[String]>(value: [])
    
    let pagerView = TYCyclePagerView().then { make in
        make.isInfiniteLoop = true
        make.autoScrollInterval = 3.0
        make.register(BannerCell.self,  forCellWithReuseIdentifier: BannerCell.reuseIndentifier)
    }
    
    let pageControl = UIPageControl()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension BannerView {
    
    func setupUI() {
        
        clipsToBounds = true
        
        pagerView.dataSource = self
        pagerView.delegate = self
        
        addSubview(pagerView)
        pagerView.addSubview(pageControl)
        
        pagerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.bottom.centerX.width.equalToSuperview()
            make.height.equalTo(25)
        }
        
        bannerArray.asObservable().subscribe { [weak self] (_) in
            self?.pagerView.reloadData()
            self?.pageControl.numberOfPages = self?.bannerArray.value.count ?? 0
            }.disposed(by: rx.disposeBag)
        
    }
    
}

// MARK: TYCyclePagerViewDataSource
extension BannerView: TYCyclePagerViewDataSource, TYCyclePagerViewDelegate {
    
    func numberOfItems(in pageView: TYCyclePagerView) -> Int {
        return bannerArray.value.count
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: BannerCell.reuseIndentifier, for: index) as! BannerCell
        cell.imageView.image = UIImage(named: bannerArray.value[index])
        //cell.cuttingCorner(radius: 10)
        //cell.imageView.lc_setImage(with: QCloud_home_url + bannerArray.value[index])
        return cell
    }
    
    func layout(for pageView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let layout = TYCyclePagerViewLayout()
        layout.itemSize = CGSize(width: pageView.frame.width - 16, height: pageView.frame.height - 5)
        layout.itemSpacing = 10
        layout.layoutType = .normal
        layout.itemHorizontalCenter = true
        return layout
    }
    
    func pagerView(_ pageView: TYCyclePagerView, didScrollFrom fromIndex: Int, to toIndex: Int) {
        pageControl.currentPage = toIndex
        //topImg.kf.setImage(with: URL(string: dataArray[toIndex].pricName))
    }
    
    func pagerView(_ pageView: TYCyclePagerView, didSelectedItemCell cell: UICollectionViewCell, at index: Int) {
        
    }
}


class BannerCell: CollectionViewCell {
    
    lazy var imageView: UIImageView = UIImageView()
    
    static let reuseIndentifier = "BannerCell"
    
    override func makeUI() {
        super.makeUI()
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}
