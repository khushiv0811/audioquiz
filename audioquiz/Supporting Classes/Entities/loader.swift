//
//  loader.swift
//  Zivello-Kiosk
//
//  Created by KHUSHBOO on 12/02/19.
//  Copyright © 2019 KHUSHBOO. All rights reserved.
//

import Foundation
import UIKit
import Lottie

extension UIViewController
{
    func showhud(aview : UIView , animationname : String) -> LottieView
    {
      
        let animationView = AnimationView(name: animationname)
        animationView.frame = CGRect(x: self.view.bounds.width -  300, y: 150, width: 200, height:200)
        
        animationView.center = aview.center
        animationView.contentMode = .scaleAspectFit
       animationView.loopMode = .loop
       
        aview.addSubview(animationView)
         animationView.play()
        return animationView
    }
    
    func dismisshud(aview: LottieView)
    {
        aview.removeFromSuperview()
    }
   
}
