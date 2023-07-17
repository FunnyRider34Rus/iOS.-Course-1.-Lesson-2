//
//  AuthViewController.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 17.07.2023.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var image = UIImageView()
    private var label = UILabel()
    private var loginTextField = UITextField()
    private var passTextField = UITextField()
    private var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        
    }
    
    private func setupViews() {
    
        view.backgroundColor = .white
        
        image.image = UIImage(systemName: "person")
    
        label.text = "Authorization"
        
        loginTextField.placeholder = "Login"
        
        passTextField.placeholder = "Password"
        
        button.setTitle("LogIn", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToMainScreen), for: .touchUpInside)
        
        view.addSubview(image)
        view.addSubview(label)
        view.addSubview(loginTextField)
        view.addSubview(passTextField)
        view.addSubview(button)
        
    }
    
    private func setConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 60),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 40),
            passTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 60),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200.0),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc func goToMainScreen() {
        
        let navBarViewController = UITabBarController()
        let friendsViewController = UINavigationController(rootViewController: FriendsViewController())
        let groupsViewController = UINavigationController(rootViewController: GroupsViewController())
        let photosViewController = UINavigationController(rootViewController: PhotosViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        friendsViewController.tabBarItem.title = "Friends"
        friendsViewController.tabBarItem.image = UIImage(systemName: "person.2")
        groupsViewController.tabBarItem.title = "Groups"
        groupsViewController.tabBarItem.image = UIImage(systemName: "person.3")
        photosViewController.tabBarItem.title = "Photos"
        photosViewController.tabBarItem.image = UIImage(systemName: "photo")
        
        let controllers = [friendsViewController, groupsViewController, photosViewController]
        
        navBarViewController.viewControllers = controllers
        navBarViewController.tabBar.backgroundColor = .white
        
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let firstWindow = firstScene.windows.first else {
            return
        }
        
        firstWindow.rootViewController = navBarViewController
    }
}
