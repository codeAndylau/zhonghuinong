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
        case bindingMobile
        
        // 首页
        case delivery
        case deliveryOrderInfo
        case privateFarm
        case flash  // 抢购
        case hot(list: [GoodsInfo])    // 热销
        case scan   // 扫码溯源
        
        // 分类
        case goodsDetail(id: Int)
        case searchGoodsInfo
        
        // 菜篮
        case shoppingOrder(list: [CartGoodsInfo])
        
        // 我的
        case mineMember(info: UserBanlance)
        case mineVegetables(info: UserBanlance)
        case mineWallet(info: UserBanlance)
        case mineAbout
        case mineMessage
        case mineSetting
        case mineOrder(index: Int)
        case mineLogistics(order_no: String)
        case mineAddress
        case mineAddressModify(info: UserAddressInfo)
        
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
        case .bindingMobile: return MobileBindingViewController()
            
            
        // 首页
        case .delivery: return DeliveryViewController()
        case .deliveryOrderInfo: return DeliveryOrderInfoViewController()
        case .privateFarm: return PrivatefarmViewController()
        case .flash: return FlashViewController()
            
            
        // MARK: - FIXME 热销排行
        case .hot(let list):
            let vc = HotGoodsViewController()
            vc.hotsaleList = list
            return vc
        case .scan: return ScanViewController()
            
            
        // 分类
        case .searchGoodsInfo: return SearchViewController()
            
        case .goodsDetail(let id):
            let vc = GoodsDetailViewController()
            vc.goodId = id
            return vc
            
            // 菜篮
            
        // 购物车确认订单
        case .shoppingOrder(let list):
            let vc = OrderViewController()
            vc.goodsList = list
            return vc
            
        // 我的
        case .mineAbout: return MineAboutViewController()
        case .mineMessage: return MineMessageViewController()
        case .mineSetting: return MineSettingViewController()
            
        case .mineLogistics(let orderId):
            let vc = MineLogisticsViewController()
            vc.order_no = orderId
            return vc
            
        case .mineVegetables(let banlance):
            let vc = MineVegetablesViewController()
            vc.banlance = banlance
            return vc
            
        case .mineWallet(let banlance):
            let vc = MineWalletViewController()
            vc.banlance = banlance
            return vc
            
        case .mineMember(let banlance):
            let vc = MineMemberViewController()
            vc.banlance = banlance
            return vc
            
        case .mineOrder(let index):
            let vc = MineOrderViewController()
            vc.defaultIndex = index
            return vc
            
            
        case .mineAddress:
            let vc = MineAddressViewController()
            
            return vc
            
        case .mineAddressModify(let info):
            let vc = MineAddressModifyViewController()
            vc.addressInfo = info
            return vc
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
