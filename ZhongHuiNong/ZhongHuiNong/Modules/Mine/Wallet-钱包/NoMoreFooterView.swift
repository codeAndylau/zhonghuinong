//
//  NoMoreFooterView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class NoMoreFooterView: View {

    let titleLab = Label().then { (lab) in
        lab.text = "就这么多了"
        lab.textColor = UIColor.hexColor(0xCCCCCC)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    let leftView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF5F5F5)
    }
    
    let rightView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF5F5F5)
    }

    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(leftView)
        addSubview(rightView)
    }
    
    override func updateUI() {
        super.updateUI()
        
        titleLab.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        leftView.snp.makeConstraints { (make) in
            make.right.equalTo(titleLab.snp.left).offset(-18)
            make.centerY.equalTo(titleLab)
            make.width.equalTo(40)
            make.height.equalTo(1)
        }
        
        rightView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right).offset(18)
            make.centerY.equalTo(titleLab)
            make.width.equalTo(40)
            make.height.equalTo(1)
        }
    }
    
    /// - Public methods
    class func loadView() -> NoMoreFooterView {
        let view = NoMoreFooterView()
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 78)
        view.backgroundColor = Color.whiteColor
        return view
    }
    
}
