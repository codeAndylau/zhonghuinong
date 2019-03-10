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
    
    var headimgUrl : String  = ""
    var isPayPassword : Bool = false
    var isVip : Bool = false            // 0是非VIP 1是个人VIP 2是企业用户
    var mobile : String = ""
    var nickname : String = ""
    var userId : Int = defaultId
    var userImg : String = ""
    var username : String = ""
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        headimgUrl <- map["headimg_url"]
        isPayPassword <- map["isPayPassword"]
        isVip <- map["isVip"]
        mobile <- map["mobile"]
        nickname <- map["nickname"]
        userId <- map["userId"]
        userImg <- map["user_Img"]
        username <- map["username"]
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
    
    static func hasUser() -> Bool {
        let user = User.currentUser()
        debugPrints("用户信息---\(String(describing: user))")
        if user.userId == -1 && user.username == "" && user.userImg == "" && user.isVip == false {
            return false
        }
        return true
    }
    
    static func currentUser() -> User {
        if let json = Defaults.shared.get(for: DefaultsKey.userKey), let user = User(JSONString: json) {
            return user
        }
        return User()
    }
    
    static func removeCurrentUser() {
        Defaults.shared.clear(DefaultsKey.userKey)
    }
}

extension User: Equatable {
    
    static func == (lhs: User, rhs: User) -> Bool {
        return (lhs.isVip    == rhs.isVip &&
                lhs.userId   == rhs.userId &&
                lhs.username == rhs.username &&
                lhs.userImg == rhs.userImg)
    }
    
}
