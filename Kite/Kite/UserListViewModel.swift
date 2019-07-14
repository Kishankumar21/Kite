//
//  UserViewModel.swift
//  Kite
//
//  Created by kishan kumar on 13/07/19.
//  Copyright © 2019 kishan kumar. All rights reserved.
//

import RxSwift

class UserListViewModel {
    
    var usersSubject: BehaviorSubject<[UserModel]> = BehaviorSubject(value: [])
    
    func parseJsonData(json: Array<Any>) {
        var allUsers = [UserModel]()
        allUsers = json.compactMap { user in
            guard let user = user as? [String: Any] else {
                return nil
            }
            return UserModel(user)
        }
        usersSubject.onNext(allUsers)
    }
}
