//
//  PhotosViewController.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 15.07.2023.
//

import UIKit

class PhotosViewController: UICollectionViewController {
    
    private let request = NetworkService()
    private var models: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos"
        collectionView.register(PhotoViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        request.getPhoto { [weak self] photos in
            self?.models = photos
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoViewCell else {
            return UICollectionViewCell()
        }
        let model = models[indexPath.row]
        cell.updateCell(model: model)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = width / 2 - 20
        return CGSize(width: height, height: height)
    }
}
