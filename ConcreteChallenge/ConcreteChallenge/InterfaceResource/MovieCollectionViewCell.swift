//
//  MovieCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 12/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    // MARK: - Outlets
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Actions
    @IBAction func favoriteButtonTapped(_ sender: Any) {
    }
    
    // MARK: - UICollectionViewCell Functions
    override func prepareForReuse() {
        self.posterImage.image = UIImage()
        self.nameLabel.text = ""
        self.favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        
        super.prepareForReuse()
    }
    
    // MARK: - Functions
    func setupCell(movie: Movie) {
        if let posterPath = movie.posterPath {
            ImageDataManager.getImageFrom(imagePath: posterPath) { (image) in
                DispatchQueue.main.async {
                    self.posterImage.image = image
                    movie.image = image
                }
            }
        } else {
            self.posterImage.image = UIImage(named: "image_unavailable")
            movie.image = self.posterImage.image
        }
        
        self.nameLabel.text = movie.title
        
        if movie.isFavorite {
            DispatchQueue.main.async {
                self.favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            }
        }
    }
}
