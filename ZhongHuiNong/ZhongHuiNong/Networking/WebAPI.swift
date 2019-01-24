//
//  WebAPI.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import Moya

protocol WebAPIType {
    var addXAuth: Bool { get }
}

enum WebAPI {
    case getmessageboardbymylocation  // 获取地区留言
    case xxx(_ p: [String: Any])
}

extension WebAPI: TargetType, WebAPIType {
    var baseURL: URL {
        return Configs.Network.releaseUrl
    }
    
    var path: String {
        switch self {
        case .getmessageboardbymylocation: return "/user/getmessageboardbymylocation"
        default: return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .xxx:
            return .post
        default:
            return .get
        }
        
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .xxx(let p):
            return .requestParameters(parameters: p, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
        
    }
    
    var headers: [String : String]? {
        return ["token": "67760905-584a-4516-87dc-5ab7490bed8b"]
    }
    
    var addXAuth: Bool {
        switch self {
        default: return true
        }
    }
    
}
