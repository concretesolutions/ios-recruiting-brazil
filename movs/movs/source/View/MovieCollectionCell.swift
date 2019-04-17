//
//  MovieCollectionCell.swift
//  movs
//
//  Created by Lorien on 15/04/19.
//  Copyright © 2019 Lorien. All rights reserved.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    func setup(with movie: Movie, favorite: Bool = false) {
        titleLabel.text = movie.title
        guard let imagePath = movie.imagePath else { return }
        setImage(with: imagePath)
    }
    
    private func setImage(with path: String) {
        imageView.clipsToBounds = true
        let url = URL(string: "https://image.tmdb.org/t/p/w500/")!.appendingPathComponent(path)
        URLSession.shared
            .dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                let capacity = 500 * 1024 * 1024
                let urlCache = URLCache(memoryCapacity: capacity, diskCapacity: capacity, diskPath: "diskPath")
                URLCache.shared = urlCache
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data!)
                }
            }
            .resume()
    }
    
}
