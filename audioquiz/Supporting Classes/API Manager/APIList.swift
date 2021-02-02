//
//  APIList.swift
//  Zivello-Kiosk
//
//  Created by RoH!T on 02/06/20.
//  Copyright © 2020 KHUSHBOO. All rights reserved.
//

import UIKit

/// Manage API List
class APIList: NSObject {
    ///
    static let serverPath = NetworkConfiguration.shared.hostURL
   
    
    
    
    /// Login API
    struct login {
        ///
        static let login = serverPath + "login.php?"
    }
    /// Registration API
    struct Registration {
        ///
        static let Registration = serverPath + "register.php?"
    }
    /// Category API
    struct Category {
        ///
        static let Category = serverPath + "category.php"
    }
    struct Subcategory
    {
           ///
           static let Subcategory = serverPath + "sub_category.php?"
       }
    struct Playlist
    {
           ///
           static let Playlist = serverPath + "playlist_quiz.php?"
       }
    
  
}
