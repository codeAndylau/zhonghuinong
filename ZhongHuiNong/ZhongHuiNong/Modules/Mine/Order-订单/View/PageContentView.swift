//
//  PageContentView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

// MARK:- 定义协议 滑动scrollview的时候执行的回调方法
protocol PageContentViewDelegate: class {
    func pageContentView(_ contentView : PageContentView,  targetIndex index: Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    // MARK:- 定义属性
    fileprivate var childVcs : [UIViewController] = []
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = kScreenW // 默认为显示第二个视图
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    // MARK:- 懒加载属性
    lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
        }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?, offsetX: CGFloat) {
        self.startOffsetX = offsetX
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK:- 设置UI界面
extension PageContentView {
    
    fileprivate func setupUI() {
        
        //TODO: 解决iOS11 上面会自动往上移动20像素
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }else {
            
        }
        
        // 1.将所有的子控制器添加父控制器中
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
        }
        // 2.添加UICollectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
        collectionView.contentOffset = CGPoint(x: startOffsetX, y: 0)
    }
    
}

// MARK:- 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2.给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        //        cell.contentView.subviews.forEach { (view) in
        //            view.removeFromSuperview()
        //        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds // 因为是水平滚动已经自动设置好了frame
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}


// MARK:- 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false  // 是禁止滚动委托
        
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    // 滑动减速后在执行
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        // 1.定义获取需要的数据
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX { // 左滑
            // 1.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 2.计算targetIndex
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 3.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 1.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        // 3.将targetIndex传递给titleView
        delegate?.pageContentView(self, targetIndex: targetIndex)
    }
}

// MARK:- 对外暴露的方法
extension PageContentView {
    
    func setCurrentIndex(_ currentIndex : Int) {
        
        // 1.记录需要进制执行代理方法
        isForbidScrollDelegate = true
        
        // 2.滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
