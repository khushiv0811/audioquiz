//
//  APIManager.swift
//  Zivello-Kiosk
//
//  Created by RoH!T on 02/06/20.
//  Copyright © 2020 KHUSHBOO. All rights reserved.
//

import UIKit
import Alamofire

/// Manage API Manager
class NetworkAPIManager: NSObject {

    // MARK: - Variables
    ///
    class var sharedInstance: NetworkAPIManager
    {
        ///
        struct Static
        {
            ///
            static var instance: NetworkAPIManager?
        }
        if Static.instance == nil
        {
            Static.instance = NetworkAPIManager()
        }
        return Static.instance ?? NetworkAPIManager() // change
    }
    
    /// requestFor
    ///
    /// - Parameters:
    ///   - url: API URL
    ///   - param: API parameter
    ///   - httpMethod: API method
    ///   - headerParam: header data
    ///   - encodingType: header encoding type
    ///   - completion: completion block for API call back result
    func getAPI(url: String, param: [String: Any]?, httpMethod: HTTPMethod = .get, headerParam: HTTPHeaders? = nil, encodingType: ParameterEncoding = URLEncoding.default, completion:@escaping (_ response: Any?, _ success: Bool) -> Void) {
        if Connectivity.isConnectedToInternet() {
            AF.request(url, method: httpMethod, parameters: param, encoding: encodingType, headers: headerParam).responseJSON { response in
                switch response.result
                {
                case .success(let json):
                    
                    completion(json, true)
                case .failure:
                    completion(response, false)
                }
            }
        } else {
            let title = "Error!"
            completion(title, false)
        }
    }
    
}

class Connectivity
{
    class func isConnectedToInternet() -> Bool
    {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
