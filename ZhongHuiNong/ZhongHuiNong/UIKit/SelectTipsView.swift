//
//  SelectTipsView.swift
//  SmartVillage
//
//  Created by Andylau on 2018/12/17.
//  Copyright © 2018 Andylau. All rights reserved.
//

import UIKit

class SelectTipsView: UIView {

    let contentWidth = kScreenW - 20
    let contentHeight = 190
    let contentView = UIView()
    
    let titleLab = UILabel().then { (lab) in
        lab.text = "是否联系客服申请VIP服务?"
        lab.textColor = UIColor.hexColor(0x444444)
        lab.font = UIFont.boldSystemFont(ofSize: 23)
    }
    
    let detailLab = UILabel().then { (lab) in
        lab.text = "也可了解峻铭农场有机蔬菜"
        lab.textColor = UIColor.hexColor(0x898989)
        lab.font = UIFont.systemFont(ofSize: 16)
    }

    let cancelBtn = UIButton().then { (btn) in
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x16C6A3), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.cuttingCorner(radius: 8)
        btn.setupBorder(width: 1, color: UIColor.hexColor(0x16C6A3))
        btn.tag = 1
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
    }
    
    let sureBtn = UIButton().then { (btn) in
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.cuttingCorner(radius: 8)
        btn.backgroundColor = Color.themeColor
        btn.tag = 2
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// 便利构造器
    convenience init() {
        self.init(frame: .zero)
        self.setupUI()
        self.showView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnAction(_ btn: UIButton) {
        removeView()
        btnClosure?(btn.tag)
    }
    
    var btnClosure: ((_ tag: Int) -> ())?

}

extension SelectTipsView {
    
    func setupUI() {
        
        // 1
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
            maker.height.equalTo(contentHeight)
        }
        
        // 2
        contentView.addSubview(titleLab)
        contentView.addSubview(detailLab)
        contentView.addSubview(sureBtn)
        contentView.addSubview(cancelBtn)
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(50)
            make.centerX.equalToSuperview()
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    
        cancelBtn.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.left.equalTo(23)
            make.bottom.equalTo(contentView).offset(-18)
            make.right.equalTo(sureBtn.snp.left).offset(-30)
            
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.right.equalTo(-23)
            make.bottom.equalTo(contentView).offset(-18)
            make.width.height.equalTo(cancelBtn)
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
