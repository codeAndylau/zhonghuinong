//
//  ViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import MBProgressHUD

class ViewController: UIViewController, Navigatable {
    
    lazy var navigator: Navigator = Navigator.shared
    lazy var reachablitity = ReachabilityManager.shared
    
    lazy var emptyDataSetTitle = ViewController.emptyTitle
    lazy var emptyDataSetImage = ViewController.emptyImage
    lazy var emptyDataSetImageTintColor = BehaviorRelay<UIColor?>(value: nil)
    
    lazy var isLoading = BehaviorRelay(value: false)
    
    lazy var contentView: View = {
        let view = View()
        view.backgroundColor = UIColor.orange
        self.view.addSubview(view)
        view.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.left.right.equalToSuperview()
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            }
        }
        return view
    }()
    
    lazy var stackView: StackView = {
        let subviews: [UIView] = []
        let view = StackView(arrangedSubviews: subviews)
        self.contentView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        return view
    }()
    
    let statusBarStyle = BehaviorRelay(value: false)
    let navigationBarHidden = BehaviorRelay(value: false)
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            if statusBarStyle.value {
                return .lightContent
            }
            return .default
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        bindViewModel()
        
        // 更改状态栏的颜色
        statusBarStyle.asObservable().subscribe(onNext: { [weak self] (flag) in
            guard let self = self else { return }
            self.setNeedsStatusBarAppearanceUpdate()
        }).disposed(by: rx.disposeBag)
        
        navigationBarHidden.asObservable().subscribe(onNext: { [weak self] (flag) in
            guard let self = self else { return }
            self.navigationController?.navigationBar.isHidden = flag
        }).disposed(by: rx.disposeBag)
        
    }
    
    /// 创建UI
    func makeUI() { view.backgroundColor = Color.whiteColor }
    /// 绑定vm
    func bindViewModel() {}
    
}

extension ViewController {
    static let emptyTitle = "暂无数据显示"
    static let emptyImage = UIImage(named: "mine_message_empty")
}



