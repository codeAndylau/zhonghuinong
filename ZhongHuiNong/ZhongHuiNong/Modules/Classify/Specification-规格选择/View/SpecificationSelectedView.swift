//
//  SpecificationSelectedView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 商品选规格view
class SpecificationSelectedView: View {
    
    
    var goodsInfo: GoodsDetailInfo = GoodsDetailInfo() {
        didSet {
            leftImg.lc_setImage(with: goodsInfo.focusImgUrl)
            titleLab.text = goodsInfo.productName
            priceLab.text = "¥\(goodsInfo.marketPrice)"
            vipPriceLab.text = "¥\(goodsInfo.salePrice)"
            stockLab.text = "库存\(goodsInfo.stock)"
            collectionView.reloadData()
        }
    }
    

    let topView = View().then { (view) in
        view.backgroundColor = Color.whiteColor
    }
    
    let guigeLab = Label().then { (lab) in
        lab.text = "规格" // 新鲜红颜奶油草莓
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }

    let leftImg = ImageView().then { (img) in
        img.backgroundColor = Color.backdropColor
        img.cuttingCorner(radius: 5)
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "" // 新鲜红颜奶油草莓
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let vipPriceLab = Label().then { (lab) in
        lab.text = "" // 新鲜红颜奶油草莓
        lab.textColor = UIColor.hexColor(0x1DD1A8)
        lab.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    let priceLab = Label().then { (lab) in
        lab.text = "" // 新鲜红颜奶油草莓
        lab.textColor = UIColor.hexColor(0xB1B1B1)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    // 库存
    let stockLab = Label().then { (lab) in
        lab.text = "" // 新鲜红颜奶油草莓
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let cancelBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "basket_cancel"), for: .normal)
    }
    
    
    let bottomView = View().then { (view) in
        view.backgroundColor = Color.whiteColor
    }
    
    let numLab = Label().then { (lab) in
        lab.text = "数量"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let addView = AddSelectedView()
    
    let sureBtn = Button(type: .custom).then { (btn) in
        btn.setTitle("确认", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
        btn.cuttingCorner(radius: 22)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(topView)
        addSubview(guigeLab)
        addSubview(collectionView)
        addSubview(bottomView)
        
        topView.addSubview(cancelBtn)
        topView.addSubview(leftImg)
        topView.addSubview(titleLab)
        topView.addSubview(vipPriceLab)
        topView.addSubview(priceLab)
        topView.addSubview(stockLab)
        
        bottomView.addSubview(numLab)
        bottomView.addSubview(addView)
        bottomView.addSubview(sureBtn)

    }
    
    override func updateUI() {
        super.updateUI()
        viewConstraints()
        topViewConstraints()
        bottomViewConstraints()
    }
    
    func viewConstraints() {
       
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(120)
        }
        
        guigeLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(topView.snp.bottom).offset(10)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(guigeLab.snp.bottom).offset(15)
            make.left.right.equalTo(self)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(150)
        }
    }
    
    func topViewConstraints() {
        
        leftImg.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(20)
            make.width.height.equalTo(90)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(leftImg.snp.top)
            make.left.equalTo(leftImg.snp.right).offset(18)
            make.right.equalTo(topView).offset(-50)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
        }
        
        priceLab.snp.makeConstraints { (make) in
            make.left.equalTo(leftImg.snp.right).offset(15)
            make.bottom.equalTo(leftImg)
        }
        
        vipPriceLab.snp.makeConstraints { (make) in
            make.left.equalTo(leftImg.snp.right).offset(15)
            make.bottom.equalTo(priceLab.snp.top)
        }
        
        stockLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(priceLab)
        }
        
    }
    
    func bottomViewConstraints() {
        numLab.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
        }
        
        addView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(numLab)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(kScreenW-100)
            make.height.equalTo(44)
        }
    }
    
    /// - Public methods
    class func loadView() -> SpecificationSelectedView {
        let view = SpecificationSelectedView()
        view.frame = CGRect(x: 0, y: kScreenH*0.4, width: kScreenW, height: kScreenH*0.6)
        view.backgroundColor = Color.whiteColor
        let corners: UIRectCorner = [.topLeft, .topRight]
        view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }
    
    
    // MARK: Lazy
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SpecificationCollectionCell.self, forCellWithReuseIdentifier: SpecificationCollectionCell.identifier)
        return collectionView
    }()
 

}

extension SpecificationSelectedView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecificationCollectionCell.identifier, for: indexPath) as! SpecificationCollectionCell
        cell.titleBtn.setTitle(goodsInfo.unit, for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let specificationVC = SpecificationViewController()
//        specificationVC.show()
    }
    
    //定义每个Cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (kScreenW-50)/3, height: 30)
    }
    
    //定义每个Section的四边间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    
}
