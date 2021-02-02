//
//  Radio_VC.swift
//  audioquiz
//
//  Created by khushboo patel on 29/12/20.
//  Copyright © 2020 Khushboo. All rights reserved.
//

import UIKit
import WebKit

class Radio_VC: UIViewController, WKNavigationDelegate
{
    var str_url = "https://radio882.com/webradio/"
    
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.navigationDelegate = self
         
        // self.setToolBar()
         
         print(str_url)
        let myURL = URL(string: str_url)
           let myRequest = URLRequest(url: myURL!)
           webView.load(myRequest)
    }
    //MARK:- IBActions
    @IBAction func onclick_back(sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void)
      {
          if (navigationAction.request.url?.absoluteString) != nil
         {
            //urlStr is what you want, I guess.
          //  str_url = navigationAction.request.url?.absoluteString
          
          
         }
          decisionHandler(.allow)
      }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
      
        print("did finish navigation")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    {
      
     
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
    {
       print("did fail navigation")
        
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
