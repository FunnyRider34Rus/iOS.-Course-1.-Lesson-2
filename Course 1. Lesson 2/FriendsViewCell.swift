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
        text.textColor = .black
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(image)
        contentView.addSubview(text)
        setupConstraints()
    }
    
    private func setupConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            text.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            text.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20)
        ])
    }
}
