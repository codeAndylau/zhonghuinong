//
//  PrivatefarmCropsModel.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/25.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

struct PrivatefarmCropsModel {
    var color: Int64 = 0x0BC7D8
    var title = "水份"
    var unit = "ppi"
    var start = "0%"
    var end: CGFloat = 100
    var total: CGFloat = 524
    
    init() {}
    init(color: Int64, title: String, total: CGFloat, unit: String, start: String, end: CGFloat) {
        self.color = color
        self.title = title
        self.total = total
        self.unit = unit
        self.start = start
        self.end = end
    }
}
