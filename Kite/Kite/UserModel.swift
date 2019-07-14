//
//  UserModel.swift
//  Kite
//
//  Created by kishan kumar on 13/07/19.
//  Copyright © 2019 kishan kumar. All rights reserved.
//

import Foundation

private struct Strings {
    static let loginNameKey = "login"
    static let userURL = "url"
}

struct UserModel {
    let loginName: String
    let userURL: String
    
    init(_ dictionary: [String: Any]) {
        loginName = dictionary[Strings.loginNameKey] as? String ?? ""
        userURL = dictionary[Strings.userURL] as? String ?? ""
    }
}
