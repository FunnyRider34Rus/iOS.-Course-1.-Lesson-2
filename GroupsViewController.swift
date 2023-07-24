//
//  GroupsViewController.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 15.07.2023.
//

import UIKit

class GroupsViewController: UITableViewController {
    
    private let request = NetworkService()
    private var models: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Groups"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.register(GroupViewCell.self, forCellReuseIdentifier: "GroupCell")
        request.getGroups { [weak self] groups in
            self?.models = groups
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupViewCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.updateCell(model: model)
        return cell
    }
}
