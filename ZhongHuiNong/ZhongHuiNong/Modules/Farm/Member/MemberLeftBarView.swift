//
//  MemberLeftBarItem.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

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
