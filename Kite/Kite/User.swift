//
//  User.swift
//  Kite
//
//  Created by kishan kumar on 14/07/19.
//  Copyright © 2019 kishan kumar. All rights reserved.
//

import Foundation

private struct Strings {
    static let imageUrlKey = "avatar_url"
    static let idKey = "id"
    static let nameKey = "name"
    static let emailKey = "email"
    static let createdAtkey = "created_at"
    static let updatedAtKey = "updated_at"
}

struct User {
    let imageUrl: String
    let id: Int
    let name: String
    let email: String
    let createdAt: Date
    let modifiedAt: Date
    
    init(_ dictionary: [String: Any]) {
        imageUrl = dictionary[Strings.imageUrlKey] as? String ?? "N/A"
        id = dictionary[Strings.idKey] as? Int ?? 0
        name = dictionary[Strings.nameKey] as? String ?? "N/A"
        email = dictionary[Strings.emailKey] as? String ?? "N/A"
        createdAt = dictionary[Strings.createdAtkey] as? Date ?? Date()
        modifiedAt = dictionary[Strings.updatedAtKey] as? Date ?? Date()
    }
}

