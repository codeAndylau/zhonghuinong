//
//  PrivatefarmHeaderView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

let PrivatefarmHeaderViewH: CGFloat = 350 - 50

class PrivatefarmHeaderView: View {

    let contView = View().then { (view) in
        view.backgroundColor = UIColor.white
    }
    
    let videoImg = ImageView().then { (img) in
        img.image = UIImage(named: "farm_video_placeholder")
        img.isUserInteractionEnabled = true
    }
    
    let playBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_play"), for: .normal)
        btn.tag = 99
    }
    
    let tipsBtn = Button().then { (btn) in
        btn.setTitle("农场直播", for: .normal)
        btn.setTitleColor(Color.whiteColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn.backgroundColor = UIColor(white: 1, alpha: 0.25)
        btn.setupBorder(width: 1, color: UIColor.white)
        btn.cuttingCorner(radius: 11)
    }
    
    let jiaoshuiView = AnnularProgressBar()
    let jiaoshuiBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_jiaoshui"), for: .normal)
    }
    
    let shifeiView = AnnularProgressBar()
    let shifeiBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_shifei"), for: .normal)
    }
    
    let shachongView = AnnularProgressBar()
    let shachongBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_shachong"), for: .normal)
    }
    
    let chucaoView = AnnularProgressBar()
    let chucaoBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_chucao"), for: .normal)
    }
    
    let bottomView = View().then { (view) in
        view.backgroundColor = UIColor.clear
    }
    
    //    let segmentedControl = FarmSegmentedView().then { (view) in
    //        view.backgroundColor = Color.backdropColor
    //    }
    
    override func makeUI() {
        super.makeUI()

        addSubview(contView)
        contView.addSubview(videoImg)
        videoImg.addSubview(playBtn)
        contView.addSubview(tipsBtn)
        
        contView.addSubview(jiaoshuiBtn)
        jiaoshuiBtn.addSubview(jiaoshuiView)
        
        contView.addSubview(shifeiBtn)
        shifeiBtn.addSubview(shifeiView)
        
        contView.addSubview(shachongBtn)
        shachongBtn.addSubview(shachongView)
        
        contView.addSubview(chucaoBtn)
        chucaoBtn.addSubview(chucaoView)
        
        
        addSubview(bottomView)
        //bottomView.addSubview(segmentedControl)
        
        jiaoshuiView.isHidden = true
        shifeiView.isHidden = true
        shachongView.isHidden = true
        chucaoView.isHidden = true
        
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
            make.right.equalTo(videoImg).offset(-15)
            make.width.equalTo(58)
            make.height.equalTo(22)
        }
        
        
        jiaoshuiBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(45)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        
        jiaoshuiView.snp.makeConstraints { (make) in
            make.edges.equalTo(jiaoshuiBtn)
        }
        
        shifeiBtn.snp.makeConstraints { (make) in
            make.left.equalTo(jiaoshuiBtn.snp.right).offset((kScreenW-290)/3)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        
        shifeiView.snp.makeConstraints { (make) in
            make.edges.equalTo(shifeiBtn)
        }
        
        shachongBtn.snp.makeConstraints { (make) in
            make.left.equalTo(shifeiBtn.snp.right).offset((kScreenW-290)/3)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        
        shachongView.snp.makeConstraints { (make) in
            make.edges.equalTo(shachongBtn)
        }
        
        chucaoBtn.snp.makeConstraints { (make) in
            make.left.equalTo(shachongBtn.snp.right).offset((kScreenW-290)/3)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(50)
        }
        
        chucaoView.snp.makeConstraints { (make) in
            make.edges.equalTo(chucaoBtn)
        }
        
        //        segmentedControl.snp.makeConstraints { (make) in
        //            make.center.equalToSuperview()
        //            make.width.equalTo(kScreenW-50)
        //            make.height.equalTo(40)
        //        }
        
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
    
    var count: Int = 30
    var timer_js: DispatchSourceTimer?
    var timer_sf: DispatchSourceTimer?
    var timer_sc: DispatchSourceTimer?
    var timer_cc: DispatchSourceTimer?
    
    deinit {
        debugPrint("私家农场操作试图销毁")
        timer_js?.cancel()
        timer_js = nil
        
        timer_sf?.cancel()
        timer_sf = nil
        
        timer_sc?.cancel()
        timer_sc = nil
        
        timer_cc?.cancel()
        timer_cc = nil
        
    }

}

enum FarmingType {
    case jiaoshui   // 浇水
    case shifei     // 施肥
    case shachong   // 杀虫
    case chucao     // 除草
}

extension PrivatefarmHeaderView {
    
    /// 设置倒计时状态
    func startTimer(_ type: FarmingType) {
        
        switch type {
        case .jiaoshui:
            jiaoshuiView.isHidden = false
            jiaoshuiBtn.setImage(UIImage(), for:.normal)
        case .shifei:
            shifeiView.isHidden = false
            shifeiBtn.setImage(UIImage(), for:.normal)
        case .shachong:
            shachongView.isHidden = false
            shachongBtn.setImage(UIImage(), for:.normal)
        case .chucao:
            chucaoView.isHidden = false
            chucaoBtn.setImage(UIImage(), for:.normal)
        }
        
        var progress:CGFloat = 0
        
        DispatchTimer(timeInterval: 1, repeatCount: count) { (timer, count) in
            
            
            
            print("pro---\(progress)--\(count)")
            
            progress += 1/30
            
            if count != 0 {
                
                switch type {
                case .jiaoshui:
                    self.timer_js = timer
                    self.jiaoshuiView.progress = Double(progress)
                    self.jiaoshuiView.titleLab.text = "\(count)s"
                case .shifei:
                    self.timer_sf = timer
                    self.shifeiView.progress = Double(progress)
                    self.shifeiView.titleLab.text = "\(count)s"
                case .shachong:
                    self.timer_sc = timer
                    self.shachongView.progress = Double(progress)
                    self.shachongView.titleLab.text = "\(count)s"
                case .chucao:
                    self.timer_cc = timer
                    self.chucaoView.progress = Double(progress)
                    self.chucaoView.titleLab.text = "\(count)s"
                }
            }
            
            if count == 0 {
                
                timer?.cancel()
                
                // 回复原形
                switch type {
                case .jiaoshui:
                    self.jiaoshuiView.isHidden = true
                    self.jiaoshuiBtn.setImage(UIImage(named: "farm_jiaoshui"), for: .normal)
                case .shifei:
                    self.shifeiView.isHidden = true
                    self.shifeiBtn.setImage(UIImage(named: "farm_shifei"), for: .normal)
                case .shachong:
                    self.shachongView.isHidden = true
                    self.shachongBtn.setImage(UIImage(named: "farm_shachong"), for: .normal)
                case .chucao:
                    self.chucaoView.isHidden = true
                    self.chucaoBtn.setImage(UIImage(named: "farm_chucao"), for: .normal)
                }
                progress = 0
            }
        }
    }
}
