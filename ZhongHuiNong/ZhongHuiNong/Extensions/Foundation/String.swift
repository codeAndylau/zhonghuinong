//
//  String.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation

extension String {

   static let ddd = localized("dd")
    
}

extension String {
    
    // 将原始的 url 编码为合法的 url
    var urlEncoding: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
    
    //将编码后的url转换回原始的url
    var urlDecoding: String {
        return self.removingPercentEncoding ?? ""
    }
    
}
