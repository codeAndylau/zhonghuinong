//
//  RxMoyaProviderType+Cache.swift
//  MoyaMapper
//
//  Created by LinXunFeng on 2018/9/26.
//

import Moya
import RxSwift
#if !COCOAPODS
import RxMoya
import CacheMoyaMapper
#endif

public extension Reactive where Base: MoyaProviderType {
    /**
     缓存网络请求:
     
     - 如果本地无缓存，直接返回网络请求到的数据
     - 如果本地有缓存，先返回缓存，再返回网络请求到的数据
     - 只会缓存请求成功的数据（缓存的数据 response 的状态码为 MMStatusCode.cache）
     - 适用于APP首页数据缓存
     
     */
    func cacheRequest(
        _ target: Base.Target,
        alwaysFetchCache: Bool = false,
        callbackQueue: DispatchQueue? = nil,
        cacheType: MMCache.CacheKeyType = .default
    ) -> Observable<Response> {
        
        var originRequest = request(target, callbackQueue: callbackQueue).asObservable()
        var cacheResponse: Response? = nil
        
        if alwaysFetchCache {
            cacheResponse = MMCache.shared.fetchResponseCache(target: target)
        } else {
            if MMCache.shared.isNoRecord(target, cacheType: cacheType) {
                MMCache.shared.record(target)
                cacheResponse = MMCache.shared.fetchResponseCache(target: target)
            }
        }
        
        // 更新缓存
        originRequest = originRequest.map { response -> Response in
            if let resp = try? response.filterSuccessfulStatusCodes() {
                MMCache.shared.cacheResponse(resp, target: target)
            }
            return response
        }
        
        guard let lxf_cacheResponse = cacheResponse else { return originRequest }
        return Observable.just(lxf_cacheResponse).concat(originRequest)
    }
}
