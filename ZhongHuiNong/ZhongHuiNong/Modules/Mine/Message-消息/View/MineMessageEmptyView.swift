//
//  MineMessageEmptyView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineMessageEmptyView: EmptyView {

    override func makeUI() {
        super.makeUI()
        sureBtn.isHidden = true
        emptyImg.image = UIImage(named: "mine_message_empty")
        titleLab.text = "一条消息都没收到哦"
    }
    
    override func updateUI() {
        super.updateUI()
    }

    /// - Public methods
    override class func loadView() -> MineMessageEmptyView {
        let view = MineMessageEmptyView()
        view.frame = CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH)
        view.backgroundColor = Color.whiteColor
        return view
    }
}
