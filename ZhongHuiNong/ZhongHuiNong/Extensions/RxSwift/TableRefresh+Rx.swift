//
//  TableRefresh+Rx.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import KafkaRefresh

extension Reactive where Base: KafkaRefreshControl {
    
    public var isAnimating: Binder<Bool> {
        return Binder(self.base) { refreshControl, active in
            
            LogInfo("刷新是否结束---\(active)")
            
            if active {
                refreshControl.beginRefreshing()
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
}
