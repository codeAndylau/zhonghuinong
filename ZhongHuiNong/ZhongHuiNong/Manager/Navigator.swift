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
        case login
        case psdLogin
        case tabs
        case detail
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
        case .login:
            let login = RootNavigationController(rootViewController: WechatLoginViewController())
            return login
        case .psdLogin:
            let wechatLogin = PasswordLoginViewController()
            return wechatLogin
        case .tabs:
            let mainVC = MainTabBarViewController()
            return mainVC
        default:
            return HomeViewController()
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
    
    func injectTabBarControllers(in target: UITabBarController) {
        if let children = target.viewControllers {
            for vc in children {
                injectNavigator(in: vc)
            }
        }
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
    
    private func injectNavigator(in target: UIViewController) {
        // view controller
        if var target = target as? Navigatable {
            target.navigator = self
            return
        }
        
        // navigation controller
        if let target = target as? UINavigationController, let root = target.viewControllers.first {
            injectNavigator(in: root)
        }
        
        // split controller
        if let target = target as? UISplitViewController, let root = target.viewControllers.first {
            injectNavigator(in: root)
        }
    }
    
    
    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        
        injectNavigator(in: target)
        
        switch transition {
        case .login(let window), .root(let window):
            //            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromBottom, animations: {
            //                window.rootViewController = target
            //            }, completion: nil)
            
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
        
        //        case login
        //        case root
        //        case navigation
        //        case modal
        //        case detail
        //        case alert
        //        case custom
        
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
