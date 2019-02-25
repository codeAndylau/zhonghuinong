//
//  Navigator.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import UIKit

protocol Navigatable {
    var navigator: Navigator { get set }
}

class Navigator {
    
    static var shared = Navigator()
    
    // MARK: - segues list, all app scenes
    enum Scene {
        
        // tabs
        case tabs
        
        // 登录
        case login
        case psdLogin
        
        // 首页
        case delivery
        case privateFarm
        
        // 分类
        
        // 菜篮
        
        // 我的
        case mineMessage
        case mineSetting
        case mineOrder
        case mineLogistics
        case mineAddress
        case mineAddressModify
        
    }
    
    enum Transition {
        case login(window: UIWindow)
        case root(window: UIWindow)
        case navigation
        case modal
        case detail
        case alert
        case custom
    }
    
    // MARK: - get a single VC
    func get(with segue: Scene) -> UIViewController? {
        switch segue {
            
        // tabs
        case .tabs: return MainTabBarViewController()
            
        // 登录
        case .login: return RootNavigationController(rootViewController: WechatLoginViewController())
        case .psdLogin: return PasswordLoginViewController()
            
            
        // 首页
        case .delivery: return DeliveryViewController()
        case .privateFarm: return PrivatefarmViewController()
            
        // 分类
            
        // 菜篮
            
        // 我的
        case .mineMessage: return MineMessageViewController()
        case .mineSetting: return MineSettingViewController()
        case .mineOrder: return MineOrderViewController()
        case .mineLogistics: return MineLogisticsViewController()
        case .mineAddress: return MineAddressViewController()
        case .mineAddressModify: return MineAddressModifyViewController()
            
            
        }
    }
    
    func pop(sender: UIViewController?, to root: Bool = false) {
        if root {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController(animated: true)
        }
    }
    
    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - invoke a single segue
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation) {
        if let target = get(with: segue) {
            show(target: target, sender: sender, transition: transition)
        }
    }
    
}

// MARK: - private
extension Navigator {
    
    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        
        switch transition {
        case .login(let window), .root(let window):
            let animate = CATransition()
            animate.duration = 0.5
            animate.type = .fade
            animate.subtype = CATransitionSubtype.fromBottom
            window.layer.add(animate, forKey: "keyWindow")
            window.rootViewController = target
        default: break
        }
        
        guard let sender = sender else {
            print("You need to pass in a sender for .navigation or .modal transitions")
            return
        }
        
        switch transition {
        case .navigation:
            if let nav = sender.navigationController {
                nav.pushViewController(target, animated: true)
            }
        case .modal:
            //present modally
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: target)
                sender.present(nav, animated: true, completion: nil)
            }
        case .detail:
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: target)
                sender.showDetailViewController(nav, sender: nil)
            }
        case .alert:
            DispatchQueue.main.async {
                sender.present(target, animated: true, completion: nil)
            }
        case .custom: return
        default: break
        }
    }
}
