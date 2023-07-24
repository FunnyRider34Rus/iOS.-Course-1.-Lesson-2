//
//  NetworkService.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 20.07.2023.
//

import Foundation

final class NetworkService {
    
    private let session = URLSession.shared
    
    static var token = ""
    static var userID = ""
    
    func getFriends(completion: @escaping([Friend]) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/friends.get?user_id=\(NetworkService.userID)&access_token=\(NetworkService.token)&fields=photo_50,online&v=5.131")
        else {
            return
        }
        
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                let friends = try JSONDecoder().decode(FriendsModel.self, from: data)
                completion(friends.response.items)
                //print(friends)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getGroups(completion: @escaping([Group]) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/groups.get?user_id=\(NetworkService.userID)&access_token=\(NetworkService.token)&extended=1&v=5.131") else {
            return
        }
        
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                let groups = try JSONDecoder().decode(GroupsModel.self, from: data)
                completion(groups.response.items)
                //print(groups)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getPhoto(completion: @escaping([Photo]) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/photos.get?user_id=\(NetworkService.userID)&access_token=\(NetworkService.token)&album_id=profile&v=5.131") else {
            return
        }
        
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                let photos = try JSONDecoder().decode(PhotosModel.self, from: data)
                completion(photos.response.items)
                //print(photos)
            } catch {
                print(error)
            }
        }.resume()
    }
}
