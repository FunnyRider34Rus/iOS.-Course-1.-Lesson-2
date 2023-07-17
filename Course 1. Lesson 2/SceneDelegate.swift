//
//  SceneDelegate.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 14.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let authViewController = UINavigationController(rootViewController:AuthViewController())
   

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = authViewController
        window?.makeKeyAndVisible()
    }
}

