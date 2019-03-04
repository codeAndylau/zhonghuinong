//
//  Token.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import ObjectMapper

/// 用户token
struct User: Mappable, Codable {
    
    var token: String = ""
    var valid: Bool = false
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        token <- map["token"]
        valid <- map["valid"]
    }

}

extension User {

    func isMine() -> Bool {
        return self == User.currentUser()
    }
    
    func save() {
        
        if let json = self.toJSONString() {
            Defaults.shared.set(json, for: DefaultsKey.userKey)
        } else {
            debugPrints("User can't be saved")
        }
    }
    
    static func currentUser() -> User? {
        if let json = Defaults.shared.get(for: DefaultsKey.userKey), let user = User(JSONString: json) {
            return user
        }
        return nil
    }
    
    static func removeCurrentUser() {
        Defaults.shared.clear(DefaultsKey.userKey)
    }
}

extension User: Equatable {
    
    static func == (lhs: User, rhs: User) -> Bool {
        return (lhs.token == rhs.token && lhs.valid == rhs.valid)
    }
    
}
