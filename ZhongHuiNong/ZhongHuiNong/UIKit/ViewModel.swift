//
//  ViewModel.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

class ViewModel: NSObject {
    
    var page = 1
    let error = ErrorTracker()
    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()

    var provider: NetworkTool
    
    override init() {
        provider = NetworkTool.shared
        super.init()
        error.asDriver().drive(onNext: { (error) in
            debugPrints("ViewModel网络请求出错---\(error.localizedDescription)")
        }).disposed(by: rx.disposeBag)
    }
    
    deinit {
        debugPrints("ViewModel生命已结束---Deinited")
    }
}
