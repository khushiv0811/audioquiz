//
//  Login_VC.swift
//  audioquiz
//
//  Created by khushboo patel on 22/08/20.
//  Copyright © 2020 Khushboo. All rights reserved.
//

import UIKit

class Login_VC: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var tf_mobilenumber : UITextField!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onclicksubmit(sender : UIButton)
    {
        if tf_mobilenumber.text!.count < 10
        {
            self.view.showToast(message: "Please enter a vaild 10 digit Mobile Number")
        }
        else
        {
        let send = APIList.login.login + "mobile=" + tf_mobilenumber.text!
       
        // get a reference to the app delegate
        let lot = self.showhud(aview: self.view, animationname: "loading")
        NetworkAPIManager.sharedInstance.getAPI(url:send, param: nil, completion: {(_ result: Any, _ success: Bool) -> Void in
            self.dismisshud(aview: lot)
        if success
        {
          
            let jsonreponse : NSDictionary = result as! NSDictionary
            if jsonreponse["success"] as! Bool == false
            {
                print(jsonreponse)
                self.view.showToast(message: jsonreponse["message"] as! String)
            }
            else
            {
            let info : NSDictionary  = jsonreponse["data"] as! NSDictionary
            
            let userid : String = info["id"] as! String
            
            UserDefaults.standard.setValue(userid, forKey: "userinfo")
            
            self.performSegue(withIdentifier: "start_segue", sender: self)
            }
        
        }
        else
        {
            self.view.showToast(message: "Could not login please try again")
        }
        })
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
