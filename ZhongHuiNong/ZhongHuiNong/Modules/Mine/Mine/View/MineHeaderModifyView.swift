//
//  MineHeaderModifyView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/26.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineHeaderModifyView: View {

    lazy var contentView = UIView()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.white
        view.contentMode = .scaleAspectFill
        view.cuttingCorner(radius: 15)
        return view
    }()
    
    lazy var modifyBtn: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.custom)
        view.setTitle("更换头像", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        view.isHidden = true
        return view
    }()
    
    override func makeUI() {
        super.makeUI()
        
        let rootView = UIApplication.shared.keyWindow
        guard let rtView = rootView else { return }
        
        rtView.addSubview(self)
        addSubview(imageView)
        addSubview(modifyBtn)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.0)

        // 单击隐藏
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(removeView))
        self.addGestureRecognizer(tapSingle)
        
        showView()
    }
    
    override func updateUI() {
        super.updateUI()
        
        self.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(kScreenW)
            make.height.equalTo(kScreenH)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.height.equalTo(kScreenW)
        }
        
        modifyBtn.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(85)
            make.height.equalTo(33)
        }
        
        modifyBtn.cuttingCorner(radius: 33/2)
        modifyBtn.setupBorder(width: 1, color: UIColor.white)
    }
    
    func showView() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIView.AnimationOptions(), animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.55)
        }, completion: nil)
    }
    
    @objc func removeView() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: [.curveEaseIn], animations: {
            self.alpha = 0.001
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    

}
