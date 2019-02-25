//
//  PrivatefarmHeaderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

let PrivatefarmHeaderViewH: CGFloat = 350

class PrivatefarmHeaderView: View {

    let contView = View().then { (view) in
        view.backgroundColor = UIColor.white
    }
    
    let videoImg = ImageView().then { (img) in
        img.image = UIImage(named: "goods_tuijian_1")
    }
    
    let playBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_play"), for: .normal)
    }
    
    let tipsBtn = Button().then { (btn) in
        btn.setTitle("农场直播", for: .normal)
        btn.setTitleColor(Color.whiteColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn.backgroundColor = UIColor(white: 1, alpha: 0.25)
        btn.setupBorder(width: 1, color: UIColor.white)
        btn.cuttingCorner(radius: 11)
    }
    
    let jiaoshuiBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_jiaoshui"), for: .normal)
    }
    
    let shifeiBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_shifei"), for: .normal)
    }
    
    let shachongBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_shachong"), for: .normal)
    }
    
    let chucaoBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_chucao"), for: .normal)
    }
    
    let bottomView = View().then { (view) in
        view.backgroundColor = UIColor.clear
    }
    
    let segmentedControl = FarmSegmentedView().then { (view) in
        view.backgroundColor = Color.backdropColor
    }
    
    override func makeUI() {
        super.makeUI()

        addSubview(contView)
        contView.addSubview(videoImg)
        contView.addSubview(playBtn)
        contView.addSubview(tipsBtn)
        
        contView.addSubview(jiaoshuiBtn)
        contView.addSubview(shifeiBtn)
        contView.addSubview(shachongBtn)
        contView.addSubview(chucaoBtn)
        
        
        addSubview(bottomView)
        bottomView.addSubview(segmentedControl)
    }
    
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(280)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(contView.snp.bottom).offset(10)
            make.left.bottom.right.equalTo(self)
        }
        
        videoImg.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(200)
        }
        
        playBtn.snp.makeConstraints { (make) in
            make.center.equalTo(videoImg)
            make.width.height.equalTo(85)
        }
        
        tipsBtn.snp.makeConstraints { (make) in
            make.top.equalTo(videoImg).offset(10)
            make.right.equalTo(videoImg).offset(-5)
            make.width.equalTo(58)
            make.height.equalTo(22)
        }
        
        
        jiaoshuiBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(45)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        
        shifeiBtn.snp.makeConstraints { (make) in
            make.left.equalTo(jiaoshuiBtn.snp.right).offset((kScreenW-290)/3)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        
        shachongBtn.snp.makeConstraints { (make) in
            make.left.equalTo(shifeiBtn.snp.right).offset((kScreenW-290)/3)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        
        chucaoBtn.snp.makeConstraints { (make) in
            make.left.equalTo(shachongBtn.snp.right).offset((kScreenW-290)/3)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        
        
        segmentedControl.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(kScreenW-50)
            make.height.equalTo(40)
        }
        
        // fillCode
        let bgLayer1 = CALayer()
        bgLayer1.frame = videoImg.bounds
        bgLayer1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.33).cgColor
        videoImg.layer.addSublayer(bgLayer1)
        // shadowCode
        videoImg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.24).cgColor
        videoImg.layer.shadowOffset = CGSize(width: 0, height: 4)
        videoImg.layer.shadowOpacity = 1
        videoImg.layer.shadowRadius = 9
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // shadowCode
        contView.layer.shadowColor = UIColor(red: 0.45, green: 0.59, blue: 0.56, alpha: 0.14).cgColor
        contView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contView.layer.shadowOpacity = 1
        contView.layer.shadowRadius = 10
    }
    
    /// Public method
    class func loadView() -> PrivatefarmHeaderView {
        let view = PrivatefarmHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: PrivatefarmHeaderViewH))
        return view
    }

}
