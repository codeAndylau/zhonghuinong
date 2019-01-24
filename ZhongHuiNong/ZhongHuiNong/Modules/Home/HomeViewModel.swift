//
//  HomeViewModel.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModel, ViewModelType {

    struct Input {
        let loadRefresh: Observable<Void>
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
    }
    
    struct Output {
        let items: BehaviorRelay<[HomePublicityEntity]>
    }
    
    func transform(input: Input) -> Output {
        let elements = BehaviorRelay<[HomePublicityEntity]>(value: [])
        
        input.loadRefresh.flatMapLatest { [weak self] () -> Observable<[HomePublicityEntity]> in
            guard let self = self else { return Observable.just([]) }
            self.page = 1
            return self.provider.getmessageboardbymylocation().trackActivity(self.loading).trackError(self.error)
            }.subscribe(onNext: { (items) in
                elements.accept(items)
            }).disposed(by: rx.disposeBag)
        
        input.headerRefresh.flatMapLatest { [weak self] () -> Observable<[HomePublicityEntity]> in
            guard let self = self else { return Observable.just([]) }
            self.page = 1
            return self.provider.getmessageboardbymylocation().trackActivity(self.headerLoading).trackError(self.error)
            }.subscribe(onNext: { (items) in
                elements.accept(items)
            }).disposed(by: rx.disposeBag)
        
        input.footerRefresh.flatMapLatest { [weak self] () -> Observable<[HomePublicityEntity]> in
            guard let self = self else { return Observable.just([]) }
            self.page += 1
            return self.provider.getmessageboardbymylocation().trackActivity(self.footerLoading).trackError(self.error)
            }.subscribe(onNext: { (items) in
                elements.accept(elements.value+items)
            }).disposed(by: rx.disposeBag)
        
        return Output(items: elements)
    }

}
