//
//  CellViewController.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 15.07.2023.
//

import UIKit

class FriendsViewCell: UITableViewCell {
    
    private let image = UIImageView(image: UIImage(systemName: "person"))
    
    private var text: UILabel = {
        let text = UILabel()
        text.text = "Friend 1"
        text.textColor = Theme.currentTheme.textColor
        return text
    }()
    
    private var onlineCircle: UIView = {
        let circle = UIView()
        circle.backgroundColor = .gray
        circle.layer.cornerRadius = 10
        return circle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Theme.currentTheme.backgroundColor
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(model: Friend) {
        text.text = (model.firstName ?? "") + (" ") + (model.lastName ?? "")
        if let online = model.online {
            let isOnline = online == 1
            if isOnline {
                onlineCircle.backgroundColor = .green
            } else {
                onlineCircle.backgroundColor = .red
            }
        }
        DispatchQueue.global().async {
            if let url = URL(string: model.photo ?? ""), let data = try?
                Data(contentsOf: url)
            {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func setupViews() {
        contentView.addSubview(image)
        contentView.addSubview(onlineCircle)
        contentView.addSubview(text)
        setupConstraints()
    }
    
    private func setupConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        onlineCircle.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            onlineCircle.bottomAnchor.constraint(equalTo: image.bottomAnchor),
            onlineCircle.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            onlineCircle.widthAnchor.constraint(equalToConstant: 12),
            onlineCircle.heightAnchor.constraint(equalToConstant: 12),
            
            text.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            text.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 40)
        ])
    }
}
