//
//  MineLogisticsHeaderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineLogisticsHeaderView: View {

    let contView = View().then { (view) in
        view.backgroundColor = UIColor.white
        view.cuttingCorner(radius: 10)
    }
    
    let leftImg = ImageView().then { (img) in
        img.image = UIImage(named: "")
        img.backgroundColor = Color.backdropColor
        img.cuttingCorner(radius: 10)
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "韵达快递"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let phoneLab = Label().then { (lab) in
        lab.text = "官方电话：95311"
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let arrowImg = ImageView().then { (img) in
        img.image = UIImage(named: "mine_arrow")
    }
    
    let orderLab = Label().then { (lab) in
        lab.text = "运单号：****"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.font = UIFont.systemFont(ofSize: 13)
    }
    
    let statusView = MineLogisticsAddressView().then { (view) in
        view.backgroundColor = UIColor.white
        view.ststus = 0
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(contView)
        contView.addSubview(leftImg)
        contView.addSubview(titleLab)
        contView.addSubview(phoneLab)
        //contView.addSubview(arrowImg)
        contView.addSubview(orderLab)
        contView.addSubview(statusView)
    }
    
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12))
        }
        
        leftImg.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(12)
            make.width.height.equalTo(88)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(leftImg.snp.right).offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        phoneLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(3)
        }
        
//        arrowImg.snp.makeConstraints { (make) in
//            make.left.equalTo(phoneLab.snp.right).offset(5)
//            make.centerY.equalTo(phoneLab)
//        }
        
        orderLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab)
            make.bottom.equalTo(leftImg.snp.bottom).offset(-15)
        }
        
        statusView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(leftImg.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-15)
        }
        
    }
    
    class func loadView() -> MineLogisticsHeaderView {
        let view = MineLogisticsHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 185))
        view.backgroundColor = UIColor.hexColor(0xFAFAFA)
        return view
    }
    
    var kuaidiInfo: KuaidiInfo = KuaidiInfo() {
        didSet {
            titleLab.text = kuaidiInfo.expName
            phoneLab.text = kuaidiInfo.expPhone
            orderLab.text = kuaidiInfo.number
            
            /*  1.在途中 2.正在派件 3.已签收 4.派送失败  */
            debugPrints("配送的状态---\(kuaidiInfo.deliverystatus)")
            let status = Int(kuaidiInfo.deliverystatus)
            statusView.ststus = (status ?? 0)
        }
    }

}
