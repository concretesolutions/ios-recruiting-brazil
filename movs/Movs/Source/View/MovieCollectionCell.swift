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
    
    let isFavoriteImage = UIImage(named: "favorite_full_icon")!
    let isNotFavoriteImage = UIImage(named: "favorite_gray_icon")!
    
    func setup(with movie: Movie) {
        titleLabel.text = movie.title
        roundBorders()
        favoriteImage.image = movie.isFavorite ? isFavoriteImage : isNotFavoriteImage
        guard let imagePath = movie.imagePath else { return }
        setImage(with: imagePath)
    }
    
    private func roundBorders() {
        let layer = CAShapeLayer()
        layer.bounds = contentView.frame
        layer.position = contentView.center
        layer.path = UIBezierPath(roundedRect: contentView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        contentView.layer.backgroundColor = UIColor.green.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.darkBlue.cgColor
        contentView.layer.mask = layer
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
