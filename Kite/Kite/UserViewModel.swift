//
//  UserViewModel.swift
//  Kite
//
//  Created by kishan kumar on 14/07/19.
//  Copyright © 2019 kishan kumar. All rights reserved.
//

import Foundation
import RxSwift

class UserViewModel {
    
    var imageSubject: BehaviorSubject<UIImage> = BehaviorSubject(value: UIImage())
    var idSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    var nameSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    var emailSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    var createdOnSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    var modifiedOnSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    func parseJsonData(json: [String: Any]?) {
        guard let json = json else { return }
        let user = User(json)
        idSubject.onNext(String(user.id))
        nameSubject.onNext(user.name)
        emailSubject.onNext(user.email)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        dateFormatter.timeZone = TimeZone.current
        createdOnSubject.onNext(dateFormatter.string(from: user.createdAt))
        modifiedOnSubject.onNext(dateFormatter.string(from: user.modifiedAt))
        
        NetworkHelper.downloadImage(url: user.imageUrl) { [weak self] image in
            guard let image = image else { return }
            self?.imageSubject.onNext(image)
        }
    }
}
