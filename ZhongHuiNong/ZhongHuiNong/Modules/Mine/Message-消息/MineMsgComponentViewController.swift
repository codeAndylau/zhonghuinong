//
//  MineMsgComponentViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/26.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import JXSegmentedView


class MineMsgComponentViewController: ViewController {

    override func makeUI() {
        super.makeUI()
        view.backgroundColor = UIColor.randomColor()
    }
  

}

extension MineMsgComponentViewController: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }
    
    func listDidAppear() { }
    func listDidDisappear() { }
}
