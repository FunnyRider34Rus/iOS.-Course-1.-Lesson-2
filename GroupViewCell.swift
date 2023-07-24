//
//  GroupViewCell.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 15.07.2023.
//

import UIKit

class GroupViewCell: UITableViewCell {
    
    private let image = UIImageView(image: UIImage(systemName: "person.2"))
    
    private var title: UILabel = {
        let text = UILabel()
        text.text = "Name"
        text.textColor = .black
        return text
    }()
    
    private var subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.text = "Description"
        subtitle.textColor = .black
        return subtitle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(model: Group) {
        title.text = model.name
        subtitle.text = model.description
        DispatchQueue.global().async {
            if let url = URL(string: model.photo ?? ""), let data = try?
                Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func setupViews() {
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        setupConstraints()
    }
    
    private func setupConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            image.widthAnchor.constraint(equalTo: image.widthAnchor),
            
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor),
            subtitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
