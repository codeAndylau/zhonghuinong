//
//  HomeView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import Then
import SnapKit

class HomeView: UIView {
    
    var viewNotReady = true

    let rightsInfo = Label().then { (lab) in
        lab.text = .rightsInfo
        lab.textAlignment = .left
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.lineBreakMode = .byWordWrapping
    }
    
    /// - Public methods
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard viewNotReady else { return }
        addSubview(rightsInfo)
        activateConstraints()
    }
    
    func activateConstraints() {
        rightsInfo.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

}

extension String {
    static let rightsInfo = "rightsInfo"
    
}
