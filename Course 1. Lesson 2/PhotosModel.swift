//
//  PhotosModel.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 20.07.2023.
//

import Foundation

struct PhotosModel: Decodable {
    var response: Photos
}

struct Photos: Decodable {
    var items: [Photo]
}

struct Photo: Decodable {
    var id: Int
    var text: String?
    var sizes: [Sizes]
}

struct Sizes: Codable {
    var url: String
}
