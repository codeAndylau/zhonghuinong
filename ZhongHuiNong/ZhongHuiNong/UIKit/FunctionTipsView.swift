//
//  FunctionTipsView.swift
//  SmartVillage
//
//  Created by Andylau on 2018/12/11.
//  Copyright © 2018 Andylau. All rights reserved.
//

import UIKit

class FunctionTipsView: UIView {

    let contentWidth = kScreenW - 30
    let contentView = UIView()

    let topImg = UIImageView().then { (img) in
        img.image = UIImage(named: "farm_delivery_nonmember")
        img.contentMode = .scaleAspectFit
    }
    
    let titleLab = UILabel().then { (lab) in
        lab.text = "暂未开通该功能"
        lab.textColor = UIColor.hexColor(0x444444)
        lab.font = UIFont.boldSystemFont(ofSize: 23)
    }
    
    let detailLab = UILabel().then { (lab) in
        lab.text = "建设之中,敬请期待"
        lab.textColor = UIColor.hexColor(0x898989)
        lab.font = UIFont.systemFont(ofSize: 16)
    }
    
    let sureBtn = UIButton().then { (btn) in
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.cuttingCorner(radius: 8)
        btn.backgroundColor = UIColor.hexColor(0x16C6A3)
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
    }
    
    let xBtn = UIButton().then { (btn) in
        btn.setTitle("3s", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x16C6A3), for: .normal)
    }

    @objc func btnAction(_ btn: UIButton) {
        removeView()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// 便利构造器
    convenience init() {
        self.init(frame: .zero)
        setupUI()
        showView()
        countdown()
    }

    func countdown() {
        DispatchTimer(timeInterval: 1, repeatCount: 4) { (timer, count) in
            self.xBtn.setTitle("\(count)s", for: .normal)
            if count <= 0 {
                self.xBtn.setTitle("", for: .normal)
                self.removeView()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FunctionTipsView {
    
    func setupUI() {
        
        let rootView = UIApplication.shared.keyWindow
        guard let rtView = rootView else { return }
        
        rtView.addSubview(self)
        addSubview(contentView)
        
        contentView.cuttingCorner(radius: 8)
        contentView.backgroundColor = UIColor.white
        backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        self.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalTo(UIScreen.main.bounds.size.width)
            maker.height.equalTo(UIScreen.main.bounds.size.height)
        }
        
        contentView.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalTo(contentWidth)
            maker.height.equalTo(280)
        }
        
        // 2. 添加子试图
        contentView.addSubview(topImg)
        contentView.addSubview(titleLab)
        contentView.addSubview(detailLab)
        contentView.addSubview(sureBtn)
        contentView.addSubview(xBtn)
        
        topImg.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(22)
            make.centerX.equalTo(contentView)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(topImg.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.left.equalTo(40)
            make.right.equalTo(40).offset(-40)
            make.bottom.equalTo(contentView).offset(-20)
        }
        
        xBtn.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.equalTo(-10)
        }

    }
    
    func showView() {
        contentView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIView.AnimationOptions(), animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.contentView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    @objc func removeView() {
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: [.curveEaseIn], animations: {
            self.alpha = 0.001
            self.contentView.removeFromSuperview()
        }) { (_) in
            self.removeFromSuperview()
        }
        
    }
    
}
