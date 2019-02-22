//
//  MineLogisticsTablCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineLogisticsTablCell: TableViewCell, TabReuseIdentifier {

    let contView = View().then { (view) in
        view.backgroundColor = Color.whiteColor
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "【东莞市】 快件离开 【虎门中心】 已发往 【成都中转】"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.boldSystemFont(ofSize: 13)
        lab.numberOfLines = 0
    }
    
    let dateLab = Label().then { (lab) in
        lab.text = "2019-01-14 00:45:14"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let dotView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0x1DD1A8)
    }
    
    let uplineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xCECECE)
    }
    
    let downlineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xCECECE)
    }
    
    // MARK: - Property
    
    var isUpCorner = false
    var isDownCorner = false
    
    var isUpLine = false
    var isDownLine = false
    var isCurrented = false
    
    override func makeUI() {
        super.makeUI()
        backgroundColor = UIColor.hexColor(0xFAFAFA)
        addSubview(contView)
        contView.addSubview(titleLab)
        contView.addSubview(dateLab)
        contView.addSubview(dotView)
        contView.addSubview(uplineView)
        contView.addSubview(downlineView)
    }
    
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-25)
        }
        
        dateLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(5)
            make.left.right.equalTo(titleLab)
            make.bottom.equalToSuperview().offset(-15)
            make.height.equalTo(16)
        }
        
       
    }
    
    override func draw(_ rect: CGRect) {
        
        if isUpCorner == true {
            let corners: UIRectCorner = [.topLeft, .topRight]
            contView.cuttingAnyCorner(roundingCorners: corners, corner: 10)
        }
        
        if isDownCorner == true {
            let corners: UIRectCorner = [.bottomLeft, .bottomRight]
            contView.cuttingAnyCorner(roundingCorners: corners, corner: 10)
        }
        
        if isCurrented {
            dotView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(25)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(10)
            }
            dotView.cuttingCorner(radius: 5)
        }else {
            dotView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(27)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(6)
            }
            dotView.cuttingCorner(radius: 2.5)
            dotView.backgroundColor = UIColor.hexColor(0xCECECE)
        }
        
        if isUpLine {
            uplineView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(29.5)
                make.top.equalToSuperview()
                make.bottom.equalTo(dotView.snp.top)
                make.width.equalTo(1)
            }
        }
        
        if isDownLine {
            downlineView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(29.5)
                make.top.equalTo(dotView.snp.bottom)
                make.bottom.equalToSuperview()
                make.width.equalTo(1)
            }
        }
    }

}
