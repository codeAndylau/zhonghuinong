//
//  MemberLeftBarItem.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class FarmHeaderView: Button {
    
    let vip = ImageView().then { (img) in
        img.image = UIImage(named: "mine_vip_1")
    }
    
    let header = ImageView().then { (img) in
        img.image = UIImage(named: "mine_default_ portrait") // farm_head 
    }
    
    let sureBtn = Button()
    
    override func makeUI() {
        super.makeUI()
        addSubview(header)
        addSubview(vip)
        addSubview(sureBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        
        vip.snp.makeConstraints { (make) in
            make.bottom.equalTo(header.snp.top).offset(5)
            make.centerX.equalTo(self)
            make.width.equalTo(27)
            make.height.equalTo(19)
        }
        
        header.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(5)
            make.width.height.equalTo(30)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // shadowCode
        header.layer.shadowColor = UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 0.24).cgColor
        header.layer.shadowOffset = CGSize(width: 0, height: 3)
        header.layer.shadowOpacity = 1
        header.layer.shadowRadius = 4
        header.layer.cornerRadius = 15
    }
    
    /// - Public methods
    class func loadView() -> FarmHeaderView {
        let view = FarmHeaderView()
        view.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        view.backgroundColor = Color.whiteColor
        return view
    }
    
}

class MemberLeftBarView: UIButton {
    
    lazy var localImg = UIImageView()
    lazy var titleLab = UILabel()
    lazy var arrowImg = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override var intrinsicContentSize: CGSize {
        if #available(iOS 11.0, *) {
            return CGSize(width: 60, height: 30)
        } else {
            return UIView.layoutFittingExpandedSize
        }
    }
    
    func setupUI() {
        
        localImg.image = UIImage(named: "farm_local_icon")
        arrowImg.image = UIImage(named: "farm_arrowdown")
        titleLab.text = "成都"
        titleLab.textColor = UIColor.hexColor(0x333333)
        titleLab.font = UIFont.systemFont(ofSize: 15)
        
        addSubview(localImg)
        addSubview(titleLab)
        addSubview(arrowImg)
        
        localImg.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(localImg.snp.right).offset(5)
            make.right.equalTo(arrowImg.snp.left).offset(-5)
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right)
            make.centerY.equalTo(self)
            make.width.equalTo(12)
            make.height.equalTo(7)
        }
    }
}
