//
//  AppDelegate.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

     var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
            // do nothing we will have a code in SceneceDelegate for this
        } else {
            
            window = UIWindow(frame: UIScreen.main.bounds) as UIWindow?
            window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
        return true
    }
}
