//
//  CartEmptyView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

struct EmptyViewConfig {
    
    init() { }
    
    var title: String?
    var image: UIImage? = nil
    var btnTitle: String?
    
    init(title: String? = "什么也木有啊,哭晕在厕所", image: UIImage? = UIImage(named: "basket_empty"), btnTitle: String = "确定") {
        self.title = title
        self.image = image
        self.btnTitle = btnTitle
    }
    
}

class EmptyView: View {
    
    let emptyImg = ImageView().then { (img) in
        img.image = UIImage(named: "basket_empty")
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "购物车空空如也"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        lab.numberOfLines = 0
        lab.textAlignment = .center
    }
    
    let sureBtn = Button().then { (btn) in
        btn.setTitle("去逛逛", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexColor(0x1DD1A8)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.cuttingCorner(radius: 22)
        btn.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(emptyImg)
        addSubview(titleLab)
        addSubview(sureBtn)
        activateConstraints()
    }
    
    func activateConstraints() {
        
        emptyImg.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(100)
            make.centerX.equalTo(self)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(emptyImg.snp.bottom).offset(30)
            make.centerX.equalTo(emptyImg)
            make.width.equalTo(kScreenW-50)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(50)
            make.centerX.equalTo(titleLab)
            make.width.equalTo(kScreenW-100)
            make.height.equalTo(44)
        }
    }
    
    var sureBtnClosure: (()->Void)?
    
    var config = EmptyViewConfig() {
        didSet {
            if config.title != nil && config.title != "" {
                titleLab.text = config.title
            }
            if config.image != nil {
                emptyImg.image = config.image
            }
            if config.btnTitle != nil && config.btnTitle != "" {
                sureBtn.setTitle(config.btnTitle, for: .normal)
            }
        }
    }
    
    @objc func sureBtnAction() {
        sureBtnClosure?()
    }
    
    /// - Public methods
    class func loadView() -> EmptyView {
        let view = EmptyView()
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-kNavBarH-kTabBarH)
        view.backgroundColor = Color.whiteColor
        return view
    }
}


