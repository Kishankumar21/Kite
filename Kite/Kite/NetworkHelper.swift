//
//  NetworkHelper.swift
//  SmartServ
//
//  Created by kishan kumar on 23/06/19.
//  Copyright © 2019 kishan kumar. All rights reserved.
//

import Foundation
import UIKit

class NetworkHelper {
    
    // MARK: Helper Method

    /// Get all list of User
    static func getUserListFromURL(url: String, completionHandler: @escaping (_ data: Array<Any>?, _ error: Error?) -> ()) {
        guard let url = URL(string: url) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print("Request failed")
                    return
            }
            do{
                guard let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? Array<Any> else {
                    return
                }
                completionHandler(jsonResponse, nil)
            } catch let parsingError {
                print("Error", parsingError)
                completionHandler(nil, parsingError)
            }
        }
        task.resume()
    }
    
    /// get user profile
    static func getUserFromURL(url: String, completionHandler: @escaping (_ data: [String: Any]?, _ error: Error?) -> ()) {
        guard let url = URL(string: url) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print("Request failed")
                    return
            }
            do{
                guard let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? [String: Any] else {
                    return
                }
                completionHandler(jsonResponse, nil)
            } catch let parsingError {
                print("Error", parsingError)
                completionHandler(nil, parsingError)
            }
        }
        task.resume()
    }
    
    /// Dowload image
    static func downloadImage(url: String, completionHandler: @escaping (_ image: UIImage?) -> ()) {
        guard let url = URL(string: url) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                error == nil else {
                    print("Request failed")
                    return
            }
            completionHandler(UIImage(data: data))
        }
        task.resume()
    }
}
