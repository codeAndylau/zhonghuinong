//
//  FirstLaunch.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation

class FirstLaunch {
    
    typealias FlagSetter = (Bool) -> Void
    typealias FlagGetter = () -> Bool
    
    var wasLaunchBefore: Bool
    
    var isFirstLaunch: Bool {
        return !wasLaunchBefore
    }
    
    init(wasLaunchFlagSetter: FlagSetter,wasLaunchFlagGetter: FlagGetter) {
        wasLaunchBefore = wasLaunchFlagGetter()
        if wasLaunchBefore {
            wasLaunchFlagSetter(true)
        }
    }
    
    convenience init(userDefaults: UserDefaults = UserDefaults.standard, for key: String = "zhonghuinong") {
        self.init(wasLaunchFlagSetter: { (flag) in
            userDefaults.set(flag, forKey: key)
        }) { () -> Bool in
           return userDefaults.bool(forKey: key)
        }
    }
    
}
