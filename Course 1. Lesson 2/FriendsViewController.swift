//
//  ViewController.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 14.07.2023.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    private let request = NetworkService()
    private var models: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Friends"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.register(FriendsViewCell.self, forCellReuseIdentifier: "FriendCell")
        request.getFriends { [weak self] friends in
            self?.models = friends
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
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
}

