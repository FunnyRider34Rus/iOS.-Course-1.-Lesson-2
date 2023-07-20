//
//  PhotosViewController.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 15.07.2023.
//

import UIKit

class PhotosViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos"
        collectionView.register(PhotoViewCell.self, forCellWithReuseIdentifier: "cell")
        let request = NetworkService()
        request.getPhoto()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoViewCell
        
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
