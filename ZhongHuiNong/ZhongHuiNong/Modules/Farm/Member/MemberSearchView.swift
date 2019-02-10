//
//  SearchView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MemberSearchView: UIView {

    lazy var searchImg = UIImageView(image: UIImage(named: "farm_search"))
    lazy var titlelab = Label(title: "搜索食材", color: UIColor.hexColor(0x8E8E93), font: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        addSubview(searchImg)
        addSubview(titlelab)
        
        searchImg.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.centerY.equalToSuperview()
        }
        
        titlelab.snp.makeConstraints { (make) in
            make.left.equalTo(searchImg.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    class func loadView() -> MemberSearchView {
        let view = MemberSearchView(frame: CGRect(x: 16, y: 0, width: kScreenW - 32, height: 38))
        view.backgroundColor = UIColor.hexColor(0xF3F3F3)
        return view
    }
    
}