//
//  MemberRexiaoCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MemberRexiaoCell: TableViewCell, TabReuseIdentifier {

    
    lazy var dataArray = ["farm_hot_1","farm_hot_2","farm_hot_3"]
    
    var cellDidClosure: ((_ index: Int)->Void)?
    
    var hotsaleList: [GoodsInfo] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MemberRexiaoSubCell.self, forCellWithReuseIdentifier: MemberRexiaoSubCell.identifier)
        return collectionView
    }()
    
    override func makeUI() {
        super.makeUI()
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self).offset(-30)
        }
    }

}

// MARK: - DataSource
extension MemberRexiaoCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotsaleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberRexiaoSubCell.identifier, for: indexPath) as! MemberRexiaoSubCell
        cell.titleLab.text = hotsaleList[indexPath.row].productName
        cell.detailLab.text = hotsaleList[indexPath.row].unit
        cell.topImg.image = UIImage(named: dataArray[indexPath.row])
        //cell.topImg.lc_setImage(with: hotsaleList[indexPath.row])
        //        cell.titleLab.text = ["高山土鸡","有机野香猪","绿壳鸡蛋"][indexPath.row]
        //        cell.detailLab.text = ["高山散养","山野香味","自然产卵"][indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (kScreenW - 30 - 20)/3, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellDidClosure?(indexPath.item)
    }
    
}


/// 抢购的子cell
class MemberRexiaoSubCell: CollectionViewCell, TabReuseIdentifier {
    
    let contView = View()
    
    let topImg = ImageView().then { (img) in
        img.backgroundColor = Color.whiteColor
    }
    
    let tipsImg = ImageView().then { (img) in
        img.backgroundColor = Color.whiteColor
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "高山土鸡"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    let detailLab = Label().then { (lab) in
        lab.text = "四川大竹，高山散养"
        lab.textAlignment = .center
        lab.textColor = UIColor.hexColor(0xFF9C6E)
        lab.font = UIFont.boldSystemFont(ofSize: 9)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(contView)
        addSubview(topImg)
        contView.addSubview(tipsImg)
        contView.addSubview(titleLab)
        contView.addSubview(detailLab)
    }
    
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-5)
            make.bottom.equalTo(self).offset(-5)
        }
        
        topImg.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(12)
            make.right.equalTo(self).offset(-12)
            make.width.equalTo(topImg.snp.height).multipliedBy(1)
        }

        tipsImg.snp.makeConstraints { (make) in
            make.left.equalTo(contView).offset(5)
            make.top.equalTo(topImg.snp.bottom).offset(10)
            make.width.equalTo(18)
            make.height.equalTo(23)
        }

        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(tipsImg.snp.right).offset(5)
            make.centerY.equalTo(tipsImg)
            make.right.equalTo(contView.snp.right).offset(-5)
        }

        detailLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(contView.snp.bottom).offset(-5)
            make.left.equalTo(contView).offset(13)
            make.right.equalTo(contView).offset(-13)

        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // shadowCode
        contView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.09).cgColor
        contView.layer.shadowOffset = CGSize(width: 0, height: -2)
        contView.layer.shadowOpacity = 1
        contView.layer.shadowRadius = 6
        contView.layer.cornerRadius = 25
    }
    
}
