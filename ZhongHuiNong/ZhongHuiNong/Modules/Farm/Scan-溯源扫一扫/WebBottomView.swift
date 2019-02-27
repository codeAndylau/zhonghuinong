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
    
    let backBtn = Button().then { (btn) in
        btn.setTitle("返回", for: .normal)
        btn.backgroundColor = UIColor.orange
    }
    
    let forwardBtn = Button().then { (btn) in
        btn.setTitle("前进", for: .normal)
        btn.backgroundColor = UIColor.orange
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(contView)
        contView.addSubview(backBtn)
        contView.addSubview(forwardBtn)
    }
  
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(56)
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
        let view = WebBottomView(frame: CGRect(x: 0, y: kScreenH-kBottomViewH, width: kScreenW, height: kBottomViewH))
        return view
    }

}
