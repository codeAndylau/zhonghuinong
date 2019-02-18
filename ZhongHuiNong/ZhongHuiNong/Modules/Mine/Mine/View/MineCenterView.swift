//
//  MineCenterView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/14.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineCenterView: View {

    let imgView = ImageView().then { (img) in
        img.image = UIImage(named: "mine_default_ portrait")
    }
    
    let cancelBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "basket_cancel"), for: .normal)
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
    let line4View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF7F7F7)
    }
    let line5View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF7F7F7)
    }
    let line6View = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF7F7F7)
    }
    
    let bagSubView = MineCenterSubView().then { (view) in
        view.imgView.image = UIImage(named: "mine_center_zhu")
        view.titleLab.text = "钱包余额（元）"
        view.detailLab.text = "1000"
    }
    
    let peisongSubView = MineCenterSubView().then { (view) in
        view.imgView.image = UIImage(named: "mine_center_zhu")
        view.titleLab.text = "合计免费配送（次）"
        view.detailLab.text = "106"
    }
    
    let shucaiSubView = MineCenterSubView().then { (view) in
        view.imgView.image = UIImage(named: "mine_center_luobo")
        view.titleLab.text = "剩余蔬菜（斤）"
        view.detailLab.text = "1000"
    }
    
    let zhurouSubView = MineCenterSubView().then { (view) in
        view.imgView.image = UIImage(named: "mine_center_zhu")
        view.titleLab.text = "剩余野香猪肉（斤）"
        view.detailLab.text = "100"
    }
    
    let jidanSubView = MineCenterSubView().then { (view) in
        view.imgView.image = UIImage(named: "mine_center_dan")
        view.titleLab.text = "剩余鸡蛋（枚）"
        view.detailLab.text = "360"
    }
    
    let tujiSubView = MineCenterSubView().then { (view) in
        view.imgView.image = UIImage(named: "mine_center_tuji")
        view.titleLab.text = "高山土鸡（只）"
        view.detailLab.text = "24"
    }
    
    let damiSubView = MineCenterSubView().then { (view) in
        view.imgView.image = UIImage(named: "mine_center_zhu")
        view.titleLab.text = "五常大米（斤）"
        view.detailLab.text = "60"
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(imgView)
        addSubview(titleLab)
        addSubview(cancelBtn)
        
        addSubview(line1View)
        addSubview(line2View)
        addSubview(line3View)
        addSubview(line4View)
        addSubview(line5View)
        addSubview(line6View)
        
        addSubview(bagSubView)
        addSubview(peisongSubView)
        addSubview(shucaiSubView)
        addSubview(zhurouSubView)
        addSubview(jidanSubView)
        addSubview(tujiSubView)
        addSubview(damiSubView)
    }
    
    
    override func updateUI() {
        super.updateUI()
        
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(-78/2)
            make.centerX.equalTo(self)
            make.width.height.equalTo(78)
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
            make.height.equalTo(8)
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

        line4View.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(shucaiSubView.snp.bottom)
            make.width.equalTo(kScreenW)
            make.height.equalTo(1)
        }
        
        jidanSubView.snp.makeConstraints { (make) in
            make.top.equalTo(line4View.snp.bottom)
            make.left.equalTo(self)
            make.width.height.equalTo(bagSubView)
        }
        
        line5View.snp.makeConstraints { (make) in
            make.left.equalTo(jidanSubView.snp.right)
            make.centerY.equalTo(jidanSubView)
            make.width.equalTo(1)
            make.height.equalTo(50)
        }
        
        tujiSubView.snp.makeConstraints { (make) in
            make.left.equalTo(jidanSubView.snp.right).offset(1)
            make.centerY.width.height.equalTo(jidanSubView)
        }
        
        line6View.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(jidanSubView.snp.bottom)
            make.width.equalTo(kScreenW)
            make.height.equalTo(1)
        }
        
        damiSubView.snp.makeConstraints { (make) in
            make.top.equalTo(line6View.snp.bottom)
            make.left.equalTo(self)
            make.width.height.equalTo(bagSubView)
        }
        
    }
    
    /// - Public methods
    class func loadView() -> MineCenterView {
        let view = MineCenterView()
        view.frame = CGRect(x: 0, y: kScreenH-500, width: kScreenW, height: 500)
        //let corners: UIRectCorner = [.topLeft, .topRight]
        //view.cuttingAnyCorner(roundingCorners: corners, corner: 16)
        return view
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
