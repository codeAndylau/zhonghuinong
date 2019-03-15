//
//  MineCenterView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/14.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import ObjectMapper
import Kingfisher

class MineCenterView: View {

    let imgView = ImageView().then { (img) in
        img.image = UIImage(named: "mine_default_ portrait")
        img.cuttingCorner(radius: 40)
        
    }
    
    let cancelBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: ""), for: .normal) // basket_cancel
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "Sofietje Boksem"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    let line1View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF7F7F7)
    }
    let line2View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF7F7F7)
    }
    let line3View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF7F7F7)
    }
    
    let bagSubView = MineCenterSubView().then { (view) in
        view.imgView.image = UIImage(named: "mine_center_zhu")
        view.titleLab.text = "钱包余额（元）"
        view.detailLab.text = "0"
    }
    
    let peisongSubView = MineCenterSubView().then { (view) in
        view.imgView.image = UIImage(named: "mine_center_quan")
        view.titleLab.text = "优惠券（张））"
        view.detailLab.text = "0"
    }
    
    let shucaiSubView = MineCenterSubView().then { (view) in
        view.imgView.image = UIImage(named: "mine_center_luobo")
        view.titleLab.text = "剩余蔬菜（斤）"
        view.detailLab.text = "0"
    }
    
    let zhurouSubView = MineCenterSubView().then { (view) in
        view.imgView.image = UIImage(named: "mine_center_cart")
        view.titleLab.text = "免费配送（次）"
        view.detailLab.text = "0"
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(imgView)
        addSubview(titleLab)
        addSubview(cancelBtn)
        
        addSubview(line1View)
        addSubview(line2View)
        addSubview(line3View)
        
        addSubview(bagSubView)
        addSubview(peisongSubView)
        addSubview(shucaiSubView)
        addSubview(zhurouSubView)

        fetchUserBalance()
    }
    
    
    override func updateUI() {
        super.updateUI()
        
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(-78/2)
            make.centerX.equalTo(self)
            make.width.height.equalTo(80)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(11)
            make.centerX.equalTo(self)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.right.top.equalTo(self)
        }
        
        bagSubView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(11)
            make.left.equalTo(self)
            make.width.equalTo(kScreenW/2)
            make.height.equalTo(80)
        }
        
        line1View.snp.makeConstraints { (make) in
            make.left.equalTo(bagSubView.snp.right)
            make.centerY.equalTo(bagSubView)
            make.width.equalTo(1)
            make.height.equalTo(50)
        }
        
        peisongSubView.snp.makeConstraints { (make) in
            make.left.equalTo(bagSubView.snp.right).offset(1)
            make.centerY.width.height.equalTo(bagSubView)
        }

        line2View.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(bagSubView.snp.bottom)
            make.width.equalTo(kScreenW)
            make.height.equalTo(1)
        }
        
        shucaiSubView.snp.makeConstraints { (make) in
            make.top.equalTo(line2View.snp.bottom)
            make.left.equalTo(self)
            make.width.height.equalTo(bagSubView)
        }
        
        line3View.snp.makeConstraints { (make) in
            make.left.equalTo(shucaiSubView.snp.right)
            make.centerY.equalTo(shucaiSubView)
            make.width.equalTo(1)
            make.height.equalTo(50)
        }
        
        zhurouSubView.snp.makeConstraints { (make) in
            make.left.equalTo(shucaiSubView.snp.right).offset(1)
            make.centerY.width.height.equalTo(shucaiSubView)
        }

    }
    
    /// - Public methods
    class func loadView() -> MineCenterView {
        let view = MineCenterView()
        view.frame = CGRect(x: 0, y: kScreenH-500, width: kScreenW, height: 300)
//        let corners: UIRectCorner = [.topLeft, .topRight]
//        view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
    }
    
    var balance: UserBanlance = UserBanlance() {
        didSet {
            debugPrints("用户的额度信息---\(balance)")
            
            let user = User.currentUser()
            
            imgView.lc_setImage(with: user.userImg)
            
            
            titleLab.text = user.username
            
            bagSubView.detailLab.text = "\(balance.creditbalance)"
            shucaiSubView.detailLab.text = "\(balance.weightbalance)"
            zhurouSubView.detailLab.text = "\(balance.deliverybalance)"
        }
    }
    
    func fetchUserBalance() {
        let params = ["userid": User.currentUser().userId]
        WebAPITool.request(WebAPI.userBalance(params), complete: { (value) in
            if  let balance = Mapper<UserBanlance>().map(JSONObject: value.object) {
                self.balance = balance
            }
        }) { (error) in
            debugPrints("请求额度出错---\(error)")
        }
    }

}

class MineCenterSubView: View {
    
    let contView = View()
    
    let imgView = ImageView().then { (img) in
        img.image = UIImage(named: "mine_center_zhu")
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "剩余蔬菜（斤）"
        lab.textColor = UIColor.hexColor(0x333333)
        lab.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    let detailLab = Label().then { (lab) in
        lab.text = "8888"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 16)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(contView)
        contView.addSubview(imgView)
        addSubview(titleLab)
        addSubview(detailLab)
    }
    
    
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(60)
        }
        
        imgView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(contView.snp.right)
            make.top.equalTo(20)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.left)
            make.top.equalTo(titleLab.snp.bottom).offset(5)
        }
        
    }
    
}
