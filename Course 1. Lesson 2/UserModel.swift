//
//  UserModel.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 29.07.2023.
//

struct UserModel: Decodable {
    var response: [User]
}
    
struct User: Decodable {
    var firstName: String?
    var lastName: String?
    var photo: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_400_orig"
    }
}
