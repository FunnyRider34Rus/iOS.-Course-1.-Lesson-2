//
//  ProfileViewController.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 29.07.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var networkService = NetworkService()
    private var profileImage = UIImageView(image: UIImage(systemName: "person"))
    private var isUserProfile: Bool
    
    private var profileName: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.textColor = Theme.currentTheme.textColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Night theme"
        label.textColor = Theme.currentTheme.textColor
        label.textAlignment = .center
        return label
    }()
    
    private var themeSwitch: UISwitch = {
        let mSwitch = UISwitch()
        mSwitch.isOn = false
        mSwitch.isEnabled = true
        return mSwitch
    }()
    
    init(name: String? = nil, photo: UIImage? = nil, isUserProfile: Bool) {
            self.isUserProfile = isUserProfile
            super.init(nibName: nil, bundle: nil)
            profileName.text = name
            profileImage.image = photo
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = Theme.currentTheme.backgroundColor
        themeSwitch.addTarget(self, action: #selector(switchState(_:)), for: .valueChanged)
        setupViews()
        if isUserProfile {
            networkService.getProfile { [weak self] user in
                self?.updateData(model: user)
            }
        } else {
            themeSwitch.isHidden = true
        }
    }
    
    @objc func switchState(_ sender: UISwitch!) {
        if sender.isOn {
            Theme.currentTheme = NightTheme()
        } else {
            Theme.currentTheme = DayTheme()
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
        DispatchQueue.main.async {
            self.profileName.text = (model.firstName ?? "") + " " + (model.lastName ?? "")
        }
    }
    
    private func setupViews() {
        view.addSubview(profileImage)
        view.addSubview(profileName)
        view.addSubview(themeLabel)
        view.addSubview(themeSwitch)
        setupConstraints()
    }
    
    private func setupConstraints() {
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileName.translatesAutoresizingMaskIntoConstraints = false
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        themeSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            profileName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 30),
            profileName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            themeLabel.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 60),
            themeLabel.leadingAnchor.constraint(equalTo: profileName.leadingAnchor),
            
            themeSwitch.centerYAnchor.constraint(equalTo: themeLabel.centerYAnchor),
            themeSwitch.leadingAnchor.constraint(equalTo: themeLabel.trailingAnchor, constant: 20)
        ])
    }
}
