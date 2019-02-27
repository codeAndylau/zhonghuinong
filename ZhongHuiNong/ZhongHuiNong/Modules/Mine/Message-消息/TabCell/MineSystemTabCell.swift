//
//  MineSystemTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/27.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineSystemTabCell: TableViewCell, TabReuseIdentifier {

    let contView = View().then { (view) in
        view.backgroundColor = Color.whiteColor
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "您该选周五配送的蔬菜了"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let detailLab = Label().then { (lab) in
        lab.text = "你吃你最想吃的啥擦即可擦看不出卡刷撒看几遍才看见…"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.numberOfLines = 0
    }
    
    let dateLab = Label().then { (lab) in
        lab.text = "15:20"
        lab.textColor = UIColor.hexColor(0xC8C8C8)
        lab.textAlignment = .right
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(contView)
        contView.addSubview(titleLab)
        contView.addSubview(detailLab)
        contView.addSubview(dateLab)
        
    }
    
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12))
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(12)
        }
        
        dateLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalTo(titleLab)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(5)
            make.left.equalTo(titleLab)
            make.right.equalToSuperview().offset(-12)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // shadowCode
        contView.layer.shadowColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.2).cgColor
        contView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contView.layer.shadowOpacity = 1
        contView.layer.shadowRadius = 5
        contView.layer.cornerRadius = 10
    }


}
