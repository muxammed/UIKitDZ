//
//  SceneDelegate.swift
//  UIKitDZ
//
//  Created by muxammed on 21.09.2022.
//

import UIKit
/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(frame: windowScene.coordinateSpace.bounds) as UIWindow?
            window?.windowScene = windowScene
            window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
            window?.makeKeyAndVisible()
        
    }

}
