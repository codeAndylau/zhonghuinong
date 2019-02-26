//
//  MineAddressBottomView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineAddressBottomView: View {
    
    let contView = View().then { (view) in
        view.backgroundColor = UIColor.white
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xE5E5E5)
    }
    
    let sureBtn = Button().then { (btn) in
        btn.setTitle("+添加地址", for: .normal)
        btn.backgroundColor = Color.theme1DD1A8
        btn.cuttingCorner(radius: 22)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(contView)
        contView.addSubview(lineView)
        contView.addSubview(sureBtn)
    }
    
    override func updateUI() {
        super.updateUI()
        
        contView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(56)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(kScreenW-32)
            make.height.equalTo(44)
        }
    }
    
    
    /// Public method
    
    class func loadView() -> MineAddressBottomView {
        let view = MineAddressBottomView(frame: CGRect(x: 0, y: kScreenH-kBottomViewH, width: kScreenW, height: kBottomViewH))
        return view
    }

}
