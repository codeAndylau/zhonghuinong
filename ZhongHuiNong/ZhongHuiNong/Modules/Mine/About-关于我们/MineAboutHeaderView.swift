//
//  MineAboutHeaderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/26.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineAboutHeaderView: View {

    let iconImg = ImageView().then { (img) in
        img.image = UIImage(named: "app_icon")
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "峻铭健康"
        lab.textColor = UIColor.hexColor(0x524C4A)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 26)
    }
    
    let detailLab = Label().then { (lab) in
        lab.text = "版本号 1.0.0"
        lab.textColor = UIColor.hexColor(0xADADAD)
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(iconImg)
        addSubview(titleLab)
        addSubview(detailLab)
    }
    
    override func updateUI() {
        super.updateUI()
        
        iconImg.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.centerX.equalTo(self)
            make.width.height.equalTo(110)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(iconImg.snp.bottom).offset(15)
            make.centerX.equalTo(self)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom)
            make.centerX.equalTo(self)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // shadowCode
        iconImg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        iconImg.layer.shadowOffset = CGSize(width: 0, height: 4)
        iconImg.layer.shadowOpacity = 1
        iconImg.layer.shadowRadius = 5
        iconImg.layer.cornerRadius = 20
        
    }

    /// - Public methods
    
    class func loadView() -> MineAboutHeaderView {
        let view = MineAboutHeaderView()
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 220)
        view.backgroundColor = Color.whiteColor
        return view
    }
}
