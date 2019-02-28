//
//  WebBottomView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/27.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class WebBottomView: View {

    let contView = View()
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF5F5F5)
    }
    
    let backBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_arrow_left"), for: .normal)
    }
    
    let forwardBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_arrow"), for: .normal)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(contView)
        contView.addSubview(lineView)
        contView.addSubview(backBtn)
        contView.addSubview(forwardBtn)
    }
  
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(56)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        backBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kScreenW/2-60)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(56)
        }
        
        forwardBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kScreenW/2+4)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(56)
        }
    }
    
    /// Public method
    class func loadView() -> WebBottomView {
        let view = WebBottomView(frame: CGRect(x: 0, y: kScreenH-kBottomViewH-12, width: kScreenW, height: kBottomViewH-12))
        return view
    }

}
