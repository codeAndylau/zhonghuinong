//
//  TabCellProtocol.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation

// tab复用标示
protocol TabReuseIdentifier {}
extension TabReuseIdentifier {
    static var identifier: String { return "\(self)" }
}
