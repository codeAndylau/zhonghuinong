//
//  Reachability.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import Reachability
import RxSwift

///  网络监听管理
class ReachabilityManager: NSObject {
    
    static let shared = ReachabilityManager()
    
    let reachability = Reachability.init()
    let reachreplay = ReplaySubject<Bool>.create(bufferSize: 1)
    let reconnection = PublishSubject<Bool>()  // FIXME: 暂时不需要该属性
    
    var reach: Observable<Bool> {
        return reachreplay.asObserver()
    }
    
    override init() {
        super.init()
        
        /// 当网络状态可用的时候
        reachability?.whenReachable = { _ in
            DispatchQueue.main.async {
                self.reachreplay.onNext(true)
            }
        }
        
        reachability?.whenUnreachable =  {  _ in
            DispatchQueue.main.async {
                self.reachreplay.onNext(false)
            }
        }
        
        do {
            try reachability?.startNotifier()
            reachreplay.onNext(reachability?.connection != .none)
        } catch {
            debugPrints("Unable to start notifier")
        }
    }
    
    // 当应用程序上线时(可能立即完成)完成的可观察的
    func connectedToInternet() -> Observable<Bool> {
        return ReachabilityManager.shared.reach
    }
}


