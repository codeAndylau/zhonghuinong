//
//  MemberQianggouCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MemberQianggouCell: TableViewCell, TabReuseIdentifier {
    
    lazy var dataArray = ["farm_flash_1","farm_flash_2","farm_flash_3"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MemberQianggouSubCell.self, forCellWithReuseIdentifier: MemberQianggouSubCell.identifier)
        return collectionView
    }()
    
    override func makeUI() {
        super.makeUI()
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self)
        }
    }
    
}

// MARK: - DataSource
extension MemberQianggouCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberQianggouSubCell.identifier, for: indexPath) as! MemberQianggouSubCell
        cell.topImg.image = UIImage(named: dataArray[indexPath.row])
        return cell
    }
    
    //定义每个Cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (kScreenW - 30 - 10)/3, height: 200)
    }
    
    //定义每个Section的四边间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
}

/// 抢购的子cell
class MemberQianggouSubCell: CollectionViewCell, TabReuseIdentifier {

    let topImg = ImageView().then { (img) in
        img.backgroundColor = Color.whiteColor
    }
    
    let tipsImg = ImageView().then { (img) in
        img.backgroundColor = Color.whiteColor
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "有机草莓500g"
        lab.textColor = UIColor.hexColor(0x444444)
        lab.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    let moneyLab = Label().then { (lab) in
        lab.text = "¥38.8"
        lab.textColor = UIColor.hexColor(0x1DD1A8)
        lab.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    let vipImg = ImageView().then { (img) in
        img.backgroundColor = UIColor.white
    }
    
    let priceLab = Label().then { (lab) in
        lab.text = "¥ 68.8 "
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 10)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(topImg)
        topImg.addSubview(tipsImg)
        addSubview(titleLab)
        addSubview(moneyLab)
        addSubview(vipImg)
        addSubview(priceLab)
    }

    override func updateUI() {
        super.updateUI()
        
        topImg.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(self.snp.width).multipliedBy(1)
        }
        
        tipsImg.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(25)
            make.height.equalTo(16)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(topImg.snp.bottom).offset(12)
            make.left.right.equalTo(self)
        }
        
        moneyLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(5)
            make.left.equalTo(self)
        }
        
        vipImg.snp.makeConstraints { (make) in
            make.left.equalTo(moneyLab.snp.right).offset(2)
            make.bottom.equalTo(moneyLab.snp.bottom).offset(-5)
            make.width.equalTo(20)
            make.height.equalTo(9)
        }
        
        priceLab.snp.makeConstraints { (make) in
            make.top.equalTo(moneyLab.snp.bottom)
            make.left.right.equalTo(self)
        }
        
    }
    
}

