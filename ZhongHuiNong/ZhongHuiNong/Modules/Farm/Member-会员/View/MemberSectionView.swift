//
//  MemberSectionView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

enum MemberSectionType {
    case xinpin
    case qianggou
    case rexiao
    case tuijian
}

class CountDownView: View {
    
    // 倒计时lab
    lazy var hourLab = Label(title: "06", color: .white, backColor: UIColor.hexColor(0x666666), font: 10)
    lazy var minLab = Label(title: "50", color: .white, backColor: UIColor.hexColor(0x666666), font: 10)
    lazy var secondLab = Label(title: "06", color: .white, backColor: UIColor.hexColor(0x666666), font: 10)
    lazy var dot1Lab = Label(title: ":", color: UIColor.hexColor(0xA3A3A3), backColor: UIColor.white, font: 8)
    lazy var dot2Lab = Label(title: ":", color: UIColor.hexColor(0xA3A3A3), backColor: UIColor.white, font: 8)
    lazy var sureBtn = Button()
    
    override func makeUI() {
        super.makeUI()
        hourLab.cuttingCorner(radius: 2)
        minLab.cuttingCorner(radius: 2)
        secondLab.cuttingCorner(radius: 2)
        addSubview(hourLab)
        addSubview(minLab)
        addSubview(secondLab)
        addSubview(dot1Lab)
        addSubview(dot2Lab)
        addSubview(sureBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        hourLab.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(self)
            make.width.height.equalTo(15)
        }
        
        dot1Lab.snp.makeConstraints { (make) in
            make.left.equalTo(hourLab.snp.right)
            make.centerY.equalTo(self)
            make.width.equalTo(7)
            make.height.equalTo(15)
        }
        
        minLab.snp.makeConstraints { (make) in
            make.left.equalTo(dot1Lab.snp.right)
            make.centerY.equalTo(self)
            make.width.height.equalTo(15)
        }
        
        dot2Lab.snp.makeConstraints { (make) in
            make.left.equalTo(minLab.snp.right)
            make.centerY.equalTo(self)
            make.width.equalTo(7)
            make.height.equalTo(15)
        }
        
        secondLab.snp.makeConstraints { (make) in
            make.left.equalTo(dot2Lab.snp.right)
            make.centerY.equalTo(self)
            make.width.height.equalTo(15)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
    }
    
    /// - Public methods
    class func loadView() -> CountDownView {
        let view = CountDownView()
        view.frame = CGRect(x: 0, y: 0, width: 65, height: 20)
        return view
    }
    
}

class MemberSectionView: UIView {

    lazy var titleLab = Label(title: "新品上架", color: UIColor.black, boldFont: 22)
    lazy var detailLab = Label(title: "排序由销量、搜索等综合得出", color: UIColor.hexColor(0x999999), font: 12)
   
    // 倒计时lab
    lazy var countdownView = CountDownView.loadView()

    var moreBtn = Button(title: "更多", color: UIColor.hexColor(0x999999), font: 12)
    var arrorImg = UIImageView(image: UIImage(named: "mine_arrow"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(type: MemberSectionType) {
        self.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 50))
        switch type {
        case .xinpin:
            setupXinpin()
        case .qianggou:
            setupQianggou()
        case .rexiao:
            setupRexiao()
        case .tuijian:
            setupTuijian()
        }
    }
    
    func setupXinpin() {
        addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        }
    }
    
    func setupQianggou() {
        titleLab.text = "超值抢购"
        addSubview(titleLab)
        addSubview(countdownView)
        addSubview(moreBtn)
        moreBtn.addSubview(arrorImg)
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        }
        
        countdownView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right).offset(10)
            make.centerY.equalTo(self)
            make.width.equalTo(65)
            make.height.equalTo(20)
        }
        
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        arrorImg.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
        }
        
    }
    
    func setupRexiao() {
        titleLab.text = "热销排行"
        detailLab.text = "排序由销量、搜索等综合得出"
        addSubview(titleLab)
        addSubview(detailLab)
        addSubview(moreBtn)
        moreBtn.addSubview(arrorImg)
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right).offset(4)
            make.bottom.equalTo(titleLab.snp.bottom).offset(-2)
        }
        
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        arrorImg.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
        }
    }
    
    func setupTuijian() {
        titleLab.text = "爆品推荐"
        detailLab.text = "优质货源"
        addSubview(titleLab)
        addSubview(detailLab)
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        }
        detailLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right).offset(4)
            make.bottom.equalTo(titleLab.snp.bottom).offset(-2)
        }
    }
}
