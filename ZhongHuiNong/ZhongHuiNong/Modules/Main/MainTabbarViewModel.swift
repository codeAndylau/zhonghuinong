//
//  MianTabbarViewModel.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/24.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum TabbarItem {
    
    case farms      // 农场会员
    case farm       // 非会员
    case store
    case basket
    case mine
    
    
    var title: String {
        switch self {
        case .farms:return localized("首页")
        case .farm: return localized("首页")
        case .store: return localized("集市")
        case .basket: return localized("菜篮")
        case .mine: return localized("我的")
        }
    }
    
    var image: UIImage? {
        switch self {
        case .farms:return UIImage(named: "tabbar_farm_icon")?.withRenderingMode(.alwaysOriginal)
        case .farm: return UIImage(named: "tabbar_farm_icon")?.withRenderingMode(.alwaysOriginal)
        case .store: return UIImage(named: "tabbar_fair_icon")?.withRenderingMode(.alwaysOriginal)
        case .basket: return UIImage(named: "tabbar_basket_icon")?.withRenderingMode(.alwaysOriginal)
        case .mine: return UIImage(named: "tabbar_mine_icon")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .farms:return UIImage(named: "tabbar_farm_icon_h")?.withRenderingMode(.alwaysOriginal)
        case .farm: return UIImage(named: "tabbar_farm_icon_h")?.withRenderingMode(.alwaysOriginal)
        case .store: return UIImage(named: "tabbar_fair_icon_h")?.withRenderingMode(.alwaysOriginal)
        case .basket: return UIImage(named: "tabbar_basket_icon_h")?.withRenderingMode(.alwaysOriginal)
        case .mine: return UIImage(named: "tabbar_mine_icon_h")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    func getController() -> UIViewController {
        switch self {
        case .farms:
            let vc = FarmMembersViewController()
            vc.tabBarItem.title = title
            vc.tabBarItem.image = image
            vc.tabBarItem.selectedImage = selectedImage
            return RootNavigationController(rootViewController: vc)
        case .farm:
            let vc = FarmNonMemberViewController()
            vc.tabBarItem.title = title
            vc.tabBarItem.image = image
            vc.tabBarItem.selectedImage = selectedImage
            return RootNavigationController(rootViewController: vc)
        case .store:
            let vc = StoreViewController()
            vc.tabBarItem.title = title
            vc.tabBarItem.image = image
            vc.tabBarItem.selectedImage = selectedImage
            return RootNavigationController(rootViewController: vc)
        case .basket:
            let vc = BasketViewController()
            vc.tabBarItem.title = title
            vc.tabBarItem.image = image
            vc.tabBarItem.selectedImage = selectedImage
            return RootNavigationController(rootViewController: vc)
        case .mine:
            let vc = MineViewController()
            vc.tabBarItem.title = title
            vc.tabBarItem.image = image
            vc.tabBarItem.selectedImage = selectedImage
            return RootNavigationController(rootViewController: vc)
        }
    }
}

class MainTabbarViewModel: NSObject {
    
    /// 是否是会员
    var member = true
    
    func tabBarItems() -> Driver<[TabbarItem]> {
       
        tabbarConfig()
        navbarConfig()
        
        var items: [TabbarItem] = []
        if member {
            items = [.farms, .store, .basket, .mine]
        }else {
            items = [.farm, .store, .basket, .mine]
        }
        return Observable.from(optional: items).asDriver(onErrorJustReturn: [])
    }
    
    func tabbarConfig() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = Color.whiteColor
        UITabBar.appearance().tintColor = Color.themeColor
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage().getImageColorWithSize(color: Color.showImgColor, size: CGSize(width: kScreenW, height: 0.5))
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.barTitleColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.themeColor], for: .selected)
    }
    
    func navbarConfig() {
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor.hexColor(0x3a3a3a)
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}
