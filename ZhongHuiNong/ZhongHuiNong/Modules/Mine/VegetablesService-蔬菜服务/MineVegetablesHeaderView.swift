//
//  MineVegetablesHeaderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineVegetablesHeaderView: View {

    let contView = View()
    
    let titleLab = Label().then { (lab) in
        lab.text = "蔬菜卡"
        lab.textColor = UIColor.white
        lab.textAlignment = .left
        lab.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    let tipsLab = Label().then { (lab) in
        lab.text = "¥6540即可享受1000斤有机蔬菜，及96次免费配送"
        lab.textColor = UIColor.white
        lab.textAlignment = .left
        lab.font = UIFont.systemFont(ofSize: 12)
    }
    
    let chongzhiBtn = Button().then { (btn) in
        btn.setTitle("续费", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setupBorder(width: 1, color: UIColor.white)
        btn.cuttingCorner(radius: 20)
    }
    
    let imageView = ImageView().then { (img) in
        img.image = UIImage(named: "mine_vegetables")
    }
    
    let bottomView = View()
    
    let bananceLab = Label().then { (lab) in
        lab.text = "我的余额"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.textAlignment = .left
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let jinNumLab = Label().then { (lab) in
        lab.text = "0"
        lab.textColor = UIColor.hexColor(0x010205)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    let jinLab = Label().then { (lab) in
        lab.text = "剩余蔬菜斤数"
        lab.textColor = UIColor.hexColor(0x666666)
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let timeNumLab = Label().then { (lab) in
        lab.text = "0"
        lab.textColor = UIColor.hexColor(0x010205)
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    let timeLab = Label().then { (lab) in
        lab.text = "剩余免费配送次数"
        lab.textColor = UIColor.hexColor(0x666666)
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xE7E7E7)
    }
    
    let historyLab = Label().then { (lab) in
        lab.text = "我的历史订单"
        lab.textColor = UIColor.hexColor(0x999999)
        lab.textAlignment = .left
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    override func makeUI() {
        super.makeUI()
        
        addSubview(contView)
        contView.addSubview(imageView)
        contView.addSubview(titleLab)
        contView.addSubview(tipsLab)
        contView.addSubview(chongzhiBtn)
        
        addSubview(bananceLab)
        
        addSubview(bottomView)
        bottomView.addSubview(jinNumLab)
        bottomView.addSubview(jinLab)
        bottomView.addSubview(timeNumLab)
        bottomView.addSubview(timeLab)
        bottomView.addSubview(lineView)
        
        addSubview(historyLab)
    }
    
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(12)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(185)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview()
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(15)
        }
        
        tipsLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(15)
        }
        
        chongzhiBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-23)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        
        bananceLab.snp.makeConstraints { (make) in
            make.top.equalTo(contView.snp.bottom).offset(25)
            make.left.equalTo(self).offset(15)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(bananceLab.snp.bottom).offset(12)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-30)
            make.height.equalTo(100)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(50)
        }
        
        jinNumLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview()
            make.right.equalTo(lineView.snp.left)
        }
        
        timeNumLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(lineView.snp.right)
            make.right.equalToSuperview()
        }
        
        jinLab.snp.makeConstraints { (make) in
            make.top.equalTo(jinNumLab.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalTo(lineView.snp.left)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.top.equalTo(timeNumLab.snp.bottom)
            make.left.equalTo(lineView.snp.right)
            make.right.equalToSuperview()
        }
        
        historyLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.bottom.equalTo(self).offset(-5)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // fillCode
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 0.16, green: 0.84, blue: 0.61, alpha: 1).cgColor, UIColor(red: 0.04, green: 0.77, blue: 0.71, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = contView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.01, y: 0.49)
        bgLayer1.endPoint = CGPoint(x: 0.49, y: 0.49)
        bgLayer1.cornerRadius = 15
        contView.layer.insertSublayer(bgLayer1, at: 0)
        
        // shadowCode
        bottomView.layer.shadowColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.2).cgColor
        bottomView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowRadius = 5
        bottomView.layer.cornerRadius = 10

    }
    
    /// - Public methods
    class func loadView() -> MineVegetablesHeaderView {
        let view = MineVegetablesHeaderView()
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 400)
        view.backgroundColor = Color.whiteColor
        return view
    }
}
