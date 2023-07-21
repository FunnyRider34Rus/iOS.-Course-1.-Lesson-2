//
//  AuthViewController.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 17.07.2023.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        
        let url = URL(string: "https://oauth.vk.com/authorize?client_id=\(AppConst.appCode)&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&response_type=token")
        
        guard let url else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    private func setupViews() {
        view.addSubview(webView)
    }
    
    private func setupScreens() {
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

extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map{ $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        NetworkService.token = params["access_token"]!
        NetworkService.userID = params["user_id"]!
        decisionHandler(.cancel)
        webView.removeFromSuperview()
        setupScreens()
    }
}
