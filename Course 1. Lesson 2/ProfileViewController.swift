//
//  ProfileViewController.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 29.07.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var networkService = NetworkService()
    private var profileImage = UIImageView()
    private var profileName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        networkService.getProfile { [weak self] user in
            self?.updateData(model: user)
        }
    }
    
    private func updateData(model: User?) {
        guard let model = model else {
            return
        }
        DispatchQueue.global().async {
            if let url = URL(string: model.photo ?? ""), let data = try?
                Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.profileImage.image = UIImage(data: data)
                }
            }
        }
        DispatchQueue.main.sync {
            self.profileName.text = (model.firstName ?? "") + " " + (model.lastName ?? "")
        }
    }
    
    private func setupViews() {
        view.addSubview(profileImage)
        view.addSubview(profileName)
        setupConstraints()
    }
    
    private func setupConstraints() {
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            profileName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileName.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 20)
        ])
    }
}
