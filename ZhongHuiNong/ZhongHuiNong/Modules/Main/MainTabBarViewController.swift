//
//  MainTabBarViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    lazy var viewModel = MainTabbarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.tabBarItems().drive(onNext: { [weak self] (item) in
            guard let self = self  else { return }
            let _ = item.map({ self.addChild($0.getController()) })
        }).disposed(by: rx.disposeBag)

    }
}
