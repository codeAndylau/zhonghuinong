//
//  MemberHeaderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 会员headerView
class MemberHeaderView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    lazy var searchView = MemberSearchView.loadView()
    lazy var classView = MemberClassView()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MemberHeaderCell.self, forCellWithReuseIdentifier: MemberHeaderCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    class func loadView() -> MemberHeaderView {
        let view = MemberHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 285))
        return view
    }
    
    func makeUI() {
        addSubview(searchView)
        addSubview(collectionView)
        addSubview(classView)
        
        // 10 + 40 + 15 + 100 + 10 + 88 + 20
        searchView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(15)
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchView.snp.bottom).offset(15)
            make.left.equalTo(15)
            make.width.equalTo(kScreenW-15)
            make.height.equalTo(100)
        }
        
        classView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(100)
        }

    }
    
    // MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberHeaderCell.identifier, for: indexPath) as! MemberHeaderCell
        return cell
    }
    
    //定义每个Cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    //定义每个Section的四边间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

}

/// 会员headerView分类
class MemberClassView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MemberHeaderClassCell.self, forCellWithReuseIdentifier: MemberHeaderClassCell.identifier)
        return collectionView
    }()
    
    var pageControl = UIPageControl().then { (page) in
        page.numberOfPages = 2
        page.currentPage = 0
        page.currentPageIndicatorTintColor = UIColor.hexColor(0x16C6A3)
        page.pageIndicatorTintColor = UIColor.hexColor(0x16C6A3, alpha: 0.5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func makeUI() {
        backgroundColor = UIColor.white
        addSubview(collectionView)
        addSubview(pageControl)
        collectionView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(pageControl.snp.top)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(10)
        }
    }
    
    // MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberHeaderClassCell.identifier, for: indexPath) as! MemberHeaderClassCell
        if  indexPath.item > 6 {
            cell.imgView.image = UIImage()
            cell.titleLab.text = ""
        }else {
            cell.imgView.image = UIImage(named: "basket_luobo")
            cell.titleLab.text = "精品时蔬-\(indexPath.row)"
        }
        return cell
    }
    
    //定义每个Cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (kScreenW - 30 - 8)/5, height: 88)
    }
    
    //定义每个Section的四边间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.x
        pageControl.currentPage = Int(offsetY/(kScreenW-30))
    }
}

/// headercell
class MemberHeaderCell: CollectionViewCell, TabReuseIdentifier {
    
    let imgView = ImageView().then { (img) in
        img.image = UIImage(named: "farm_peisong")
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(imgView)
    }
    
    override func updateUI() {
        super.updateUI()
        imgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

/// header分类cell
class MemberHeaderClassCell: CollectionViewCell, TabReuseIdentifier {
    
    let imgView = ImageView().then { (img) in
        img.contentMode = .scaleAspectFit
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "精品时蔬"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    
    override func makeUI() {
        super.makeUI()
        addSubview(imgView)
        addSubview(titleLab)
    }
    
    override func updateUI() {
        super.updateUI()
        imgView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(titleLab.snp.top).offset(-5)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-5)
            make.centerX.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(16)
        }
    }
}
