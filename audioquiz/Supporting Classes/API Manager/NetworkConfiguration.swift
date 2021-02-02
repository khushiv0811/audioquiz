//
//  NetworkConfiguration.swift
//  Zivello-Kiosk
//
//  Created by RoH!T on 02/06/20.
//  Copyright © 2020 KHUSHBOO. All rights reserved.
//

import UIKit

/// Network configuration.
class NetworkConfiguration: NSObject
{
    
    // MARK: - Variables
    ///
    var hostURL: String = "https://rthapp.twrindia.net/quizadmin/api/"
    
    
    // MARK: - Init
    /// Initializers
    fileprivate override init()
    {
        self.buildURL = ""
        super.init()
    }
    
    /// for NetworkConfiguration
    class var shared: NetworkConfiguration
    {
        ///
        struct Static
        {
            ///
            static var instance: NetworkConfiguration?
        }
        if Static.instance == nil {
            Static.instance = NetworkConfiguration()
        }
        return Static.instance ?? NetworkConfiguration() // change
    }
    
    ///
    var buildURL: String
    {
        didSet
        {
            hostURL = "http://dailyupdatework.in/quizadmin/api/"
          
        }
    }
}
