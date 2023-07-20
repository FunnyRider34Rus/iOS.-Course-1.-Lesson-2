//
//  ViewController.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 14.07.2023.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Friends"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        let request = NetworkService()
        request.getFriends()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        FriendsViewCell()
    }
}

