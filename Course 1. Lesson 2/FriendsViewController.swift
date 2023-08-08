//
//  ViewController.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 14.07.2023.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    private let request = NetworkService()
    private var cache = Cache()
    private var models: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        models = cache.fetchFriends()
        tableView.reloadData()
        title = "Friends"
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(profileTap))
        tableView.register(FriendsViewCell.self, forCellReuseIdentifier: "FriendCell")
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
        getFriends()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendsViewCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.updateCell(model: model)
        return cell
    }
    
    func getFriends() {
        request.getFriends { [weak self] result in
            switch result {
                case .success(let friends): self?.models = friends
                    self?.cache.addFriens(friends: friends)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(_): self?.models = self?.cache.fetchFriends() ?? []
                    DispatchQueue.main.async {
                        self?.showAlert()
                    }
            }
        }
    }
    
    @objc func profileTap() {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.type = .moveIn
        animation.duration = 1
        navigationController?.view.layer.add(animation, forKey: nil)
        navigationController?.pushViewController(ProfileViewController(), animated: false)
    }
    
    @objc func update() {
        request.getFriends { [weak self] result in
            switch result {
            case .success(let friends):
                self?.models = friends
                self?.cache.addFriens(friends: friends)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                self?.models = self?.cache.fetchFriends() ?? []
                DispatchQueue.main.async {
                    self?.showAlert()
                }
                DispatchQueue.main.async {
                    self?.refreshControl?.endRefreshing()
                }
            }
        }
    }
}

private extension FriendsViewController {
    
    func showAlert() {
        let date = DateConverter.getDate(date: cache.fetchFriendsDate())
        let alert = UIAlertController(title: "Loading data error", message: "Не удалось обновить спискок друзей. Данные актуальны на \(date)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

