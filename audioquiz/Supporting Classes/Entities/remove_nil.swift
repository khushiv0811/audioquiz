//
//  remove_nil.swift
//  audioquiz
//
//  Created by khushboo patel on 22/08/20.
//  Copyright © 2020 Khushboo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func removeNullFromDict (dict : NSDictionary) -> NSDictionary
       {
           let dic = dict;

           for (key, value) in dict {

               let val : NSObject = value as! NSObject;
               if(val.isEqual(NSNull()))
               {
                   dic.setValue("", forKey: (key as? String)!)
               }
               else
               {
                   dic.setValue(value, forKey: key as! String)
               }

           }

           return dic;
       }
}
