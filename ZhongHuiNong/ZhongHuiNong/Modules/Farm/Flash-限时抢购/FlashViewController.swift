//
//  FlashViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/15.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

let FlashViewH:CGFloat = 165
let FlashViewControllerID = "FlashViewController"

class FlashViewController: ViewController {

    var childVcs : [UIViewController] = []
    

    override func makeUI() {
        super.makeUI()
        
        statusBarStyle.accept(true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationItem.titleView = titleView
        
        view.backgroundColor = Color.whiteColor
        view.addSubview(topView)
        
       
        topView.selectView.addSubview(segmentView)
        
        var style = PinterestSegmentStyle()
        style.titles = ["16:00", "18:00", "20:00", "22:00"]
        style.subTitles = ["抢购中", "即将开始", "即将开始", "即将开始"]
        style.type = .flash
        
        segmentView.style = style
        segmentView.valueChange = { [weak self] index in
            guard let self = self else { return }
                debugPrints("点击了第\(index)个")
            // 2.滚动正确的位置
            let offsetX = CGFloat(index) * kScreenW
            self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        }
        
        let one = FlashOneViewController()
        let two = FlashTwoViewController()
        let three = FlashThreeViewController()
        let four = FlashFourViewController()
        childVcs.append(one)
        childVcs.append(two)
        childVcs.append(three)
        childVcs.append(four)
        
        // 1.将所有的子控制器添加父控制器中
        for childVc in childVcs {
            addChild(childVc)
        }
        
        // 2.添加UICollectionView,用于在Cell中存放控制器的View
        collectionView.frame = CGRect(x: 0, y: FlashViewH, width: kScreenW, height: kScreenH-FlashViewH)
        collectionView.contentOffset = CGPoint(x: 0, y: 0)
        view.addSubview(collectionView)
        
        view.insertSubview(topView, aboveSubview: collectionView)
        
        //TODO: 解决iOS11 上面会自动往上移动20像素
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }

    override func bindViewModel() {
        super.bindViewModel()
    }
    
    
    // MARK: - Lazy
    lazy var titleView = UIImageView(image: UIImage(named: "farm_flash_icon"))
    
    lazy var topView = FlashView.loadView()
    
    lazy var segmentView = PinterestSegment().then { (view) in
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 56)
    }
    
    lazy var collectionView : UICollectionView = { [weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenW, height: kScreenH-FlashViewH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: FlashViewControllerID)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return collectionView
        }()
}

// MARK:- 遵守UICollectionViewDataSource
extension FlashViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashViewControllerID, for: indexPath)
        cell.contentView.subviews.forEach { (view) in view.removeFromSuperview() }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

// MARK:- 遵守UICollectionViewDelegate
extension FlashViewController : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x/kScreenW
        debugPrints("偏移量 --- \(index)")
        segmentView.setSelectIndex(index: Int(index), animated: true)
    }
    
}
