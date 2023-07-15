//
//  SceneDelegate.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 14.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let navBarViewController = UITabBarController()
    let friendsViewController = FriendsViewController()
    let groupsViewController = GroupsViewController()
    let photosViewController = PhotosViewController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        friendsViewController.tabBarItem.title = "Friends"
        friendsViewController.tabBarItem.image = UIImage(systemName: "person.2")
        groupsViewController.tabBarItem.title = "Groups"
        groupsViewController.tabBarItem.image = UIImage(systemName: "person.3")
        photosViewController.tabBarItem.title = "Photos"
        photosViewController.tabBarItem.image = UIImage(systemName: "photo")
        
        let controllers = [friendsViewController, groupsViewController, photosViewController]
        
        navBarViewController.viewControllers = controllers
        navBarViewController.tabBar.backgroundColor = .white
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navBarViewController
        window?.makeKeyAndVisible()
    }
}

