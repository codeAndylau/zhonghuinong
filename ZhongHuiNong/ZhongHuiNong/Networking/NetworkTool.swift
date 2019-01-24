//
//  RequestAPI.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

protocol ProductAPIType {
    func getmessageboardbymylocation() -> Single<[HomePublicityEntity]>
}


class NetworkTool {
    
    static let shared = NetworkTool()
    let provider: Networking
    
    init() {
        provider = Networking.networking()
    }
    
}

extension NetworkTool: ProductAPIType {
    
    func getmessageboardbymylocation() -> Single<[HomePublicityEntity]> {
        return requestArray(WebAPI.getmessageboardbymylocation, type: HomePublicityEntity.self)
    }

}


extension NetworkTool {
    
    func request(_ target: WebAPI) -> Single<Any> {
        return provider.request(target).mapJSON().observeOn(MainScheduler.instance).asSingle()
    }
    
    func requestWithoutMapping(_ target: WebAPI) -> Single<Moya.Response> {
        return provider.request(target).observeOn(MainScheduler.instance).asSingle()
    }
    
    func requestObject<T: BaseMappable>(_ target: WebAPI, type: T.Type) -> Single<T> {
        return provider.request(target)
            .mapObject(T.self)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
    func requestObjectWithKeyPath<T: BaseMappable>(_ target: WebAPI, type: T.Type) -> Single<T> {
        return provider.request(target)
            .mapObject(T.self, atKeyPath: "data")
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
    func requestArray<T: BaseMappable>(_ target: WebAPI, type: T.Type) -> Single<[T]> {
        return provider.request(target)
            .mapArray(T.self, atKeyPath: "data")
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
    
}
