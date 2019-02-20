//
//  FarmView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import SnapKit

class FarmSegmentedView: UIView {
    
    lazy var leftLab: Button = {
        let btn = Button()
        btn.setTitle("作物状态", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x9B9B9B), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        addSubview(btn)
        return btn
    }()
    
    lazy var rightLab: Button = {
        let btn = Button()
        btn.setTitle("地块作物", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x9B9B9B), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        addSubview(btn)
        return btn
    }()

    lazy var leftBtn: Button = {
        let btn = Button()
        btn.backgroundColor = UIColor.hexColor(0x16C6A3)
        btn.setTitle("作物状态", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        action()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
        action()
    }
    
    func makeUI() {
        layer.cornerRadius = 20
        backgroundColor = UIColor.hexColor(0xF8F8F8)
        addSubview(leftLab)
        addSubview(rightLab)
        addSubview(leftBtn)
        leftBtn.layer.shadowColor = UIColor(red: 0.4, green: 0.77, blue: 0.7, alpha: 1).cgColor
        leftBtn.layer.shadowOffset = .zero
        leftBtn.layer.shadowOpacity = 1
        leftBtn.layer.shadowRadius = 8
        leftBtn.layer.cornerRadius = 20
    }
    
    func action() {
        
        leftLab.rx.tap.subscribe({ [weak self] _ in
            guard let self = self else { return }
            self.leftBtn.setTitle("作物状态", for: .normal)
            UIView.animate(withDuration: 0.3, animations: {
                self.leftBtn.frame = CGRect(x: 0, y: 0, width: self.width/2, height: self.height)
            })
            self.leftBtn.layoutIfNeeded()
        }).disposed(by: rx.disposeBag)
        
        rightLab.rx.tap.subscribe({ [weak self] _ in
            guard let self = self else { return }
            self.leftBtn.setTitle("地块作物", for: .normal)
            UIView.animate(withDuration: 0.3, animations: {
                self.leftBtn.frame = CGRect(x: self.width/2, y: 0, width: self.width/2, height: self.height)
            })
            self.leftBtn.layoutIfNeeded() // 用来立即刷新不仅（不调用该方法无法实现动画移动，会变成瞬间移动）
        }).disposed(by: rx.disposeBag)
        
    }
    
    // MARK: - 属性
    var isLeft: Bool = true  // 默认是在左边的
    var leading: CGFloat = 0
    var leftConstraint: Constraint?
    
}

extension FarmSegmentedView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftLab.frame = CGRect(x: 0, y: 0, width: width/2, height: height)
        rightLab.frame = CGRect(x: width/2, y: 0, width: width/2, height: height)
        leftBtn.frame = CGRect(x: 0, y: 0, width: width/2, height: height)
    }
}


