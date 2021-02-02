//
//  SceneDelegate.swift
//  audioquiz
//
//  Created by KHUSHBOO on 24/06/20.
//  Copyright © 2020 Khushboo. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    ///
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowscene = (scene as? UIWindowScene) else { return }
        
        //Set Root View Controller
        self.window = UIWindow(windowScene: windowscene)
                      
        let nvc:UINavigationController = storyboard.instantiateViewController(withIdentifier: "rootnav") as! UINavigationController
                     
        if UserDefaults.standard.object(forKey: "userinfo") as? String == nil
        {
                          
            let rootVC = storyboard.instantiateViewController(withIdentifier: "Login_VC") as! Login_VC
            nvc.viewControllers = [rootVC]
            window?.rootViewController = nvc
        }
        else
        {
         let playlist = storyboard.instantiateViewController(withIdentifier: "SelectLanguage_VC") as! SelectLanguage_VC
                     
        nvc.viewControllers = [playlist]
        window?.rootViewController = nvc
                     
        }
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

