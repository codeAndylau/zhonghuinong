//
//  LibsManager.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import KafkaRefresh

class LibsManager: NSObject {
    
    static let shared = LibsManager()
    
    func setupLibs() {
        setupKafkaRefresh()
    }
    
    func setupKafkaRefresh() {
        if let defaults = KafkaRefreshDefaults.standard() {
            defaults.headDefaultStyle = .replicatorAllen
            defaults.footDefaultStyle = .replicatorDot
        }
    }
    
}
