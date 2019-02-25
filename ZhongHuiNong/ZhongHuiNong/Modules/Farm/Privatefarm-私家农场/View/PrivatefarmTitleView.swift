//
//  PrivatefarmTitleView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class PrivatefarmTitleView: View {

    let titleLab = Label().then { (lab) in
        lab.text = "1号园地"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    let detailLab = Label().then { (lab) in
        lab.text = "开拓新地"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 13)
    }
    
    let dotView = View()

    override var intrinsicContentSize: CGSize {
        return CGSize(width: kScreenW-250, height: 44)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(detailLab)
        addSubview(dotView)
    }
    
    override func updateUI() {
        super.updateUI()
        
        titleLab.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(self)
            make.width.height.equalTo(self).multipliedBy(0.5)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right)
            make.centerY.width.height.equalTo(titleLab)
        }
        
        dotView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(2)
            make.centerX.equalTo(titleLab)
            make.width.height.equalTo(8)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // strokeCode
        let borderLayer1 = CALayer()
        borderLayer1.frame = dotView.bounds
        borderLayer1.backgroundColor = UIColor(red: 0.08, green: 0.77, blue: 0.64, alpha: 0.22).cgColor
        borderLayer1.cornerRadius = dotView.bounds.height/2
        dotView.layer.addSublayer(borderLayer1)
        // fillCode
        let bgLayer1 = CALayer()
        bgLayer1.frame = dotView.bounds.insetBy(dx: 2, dy: 2)
        bgLayer1.backgroundColor = UIColor(red: 0.09, green: 0.78, blue: 0.64, alpha: 1).cgColor
        bgLayer1.cornerRadius = dotView.bounds.insetBy(dx: 2, dy: 2).height/2
        dotView.layer.addSublayer(bgLayer1)
        
    }
    
    /// Public method
    class func loadView() -> PrivatefarmTitleView {
        let view = PrivatefarmTitleView(frame: CGRect(x: 0, y: 0, width: kScreenW-250, height: 44))
        return view
    }
    
}
