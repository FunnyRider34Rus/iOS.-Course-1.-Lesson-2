//
//  GroupsModel.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 20.07.2023.
//

import Foundation

struct GroupsModel: Decodable {
    var responce: Groups
}

struct Groups: Decodable {
    var items: [Group]
}

struct Group: Decodable {
    var id: Int
    var name: String?
    var photo: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_50"
        case description
    }
}
