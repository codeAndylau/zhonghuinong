//
//  FarmView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import SnapKit

class FarmSegmentedView: View {

    let leftBtn = Button().then { (btn) in
        btn.setTitle("作物状态", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x9B9B9B), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let rightBtn = Button().then { (btn) in
        btn.setTitle("地块作物", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x9B9B9B), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    let topTitleBtn = Button().then { (btn) in
        btn.backgroundColor = UIColor.hexColor(0x16C6A3)
        btn.setTitle("作物状态", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    override func makeUI() {
        super.makeUI()
        
        layer.cornerRadius = 20
        backgroundColor = UIColor.hexColor(0xF8F8F8)
        addSubview(leftBtn)
        addSubview(rightBtn)
        addSubview(topTitleBtn)
        
        topTitleBtn.layer.shadowColor = UIColor(red: 0.4, green: 0.77, blue: 0.7, alpha: 1).cgColor
        topTitleBtn.layer.shadowOffset = .zero
        topTitleBtn.layer.shadowOpacity = 1
        topTitleBtn.layer.shadowRadius = 8
        topTitleBtn.layer.cornerRadius = 20
        
        //action()
    }
    
    override func updateUI() {
        super.updateUI()
        
        leftBtn.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(self)
            make.width.equalTo((kScreenW-50)/2)
            make.height.equalTo(40)
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.left.equalTo(leftBtn.snp.right)
            make.centerY.equalTo(self)
            make.width.equalTo((kScreenW-50)/2)
            make.height.equalTo(40)
        }
        
        topTitleBtn.snp.makeConstraints { (make) in
            self.leftConstrant = make.left.equalTo(self).constraint
            make.centerY.equalTo(self)
            make.width.equalTo((kScreenW-50)/2)
            make.height.equalTo(40)
        }

    }

    func action() {
        
        leftBtn.rx.tap.subscribe({ [weak self] _ in
            
            debugPrints("点击了左边")
            
            guard let self = self else { return }
            self.topTitleBtn.setTitle("作物状态", for: .normal)
            
            self.leftConstrant?.update(inset: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
            })
            
        }).disposed(by: rx.disposeBag)
        
        rightBtn.rx.tap.subscribe({ [weak self] _ in
            
            debugPrints("点击了右边")
            
            guard let self = self else { return }
            self.topTitleBtn.setTitle("地块作物", for: .normal)
            
            self.leftConstrant?.update(inset: (kScreenW-50)/2)
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded() // 用来立即刷新不仅（不调用该方法无法实现动画移动，会变成瞬间移动）
            })
        }).disposed(by: rx.disposeBag)
        
    }
    
    // MARK: - 属性
    var isLeft: Bool = true  // 默认是在左边的
    var leading: CGFloat = 0
    var leftConstrant: Constraint?
}



