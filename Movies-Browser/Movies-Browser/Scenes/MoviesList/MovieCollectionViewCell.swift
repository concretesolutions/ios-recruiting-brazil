//
//  MovieCollectionViewCell.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 20/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets -
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
}

// MARK: - Setup -
extension MovieCollectionViewCell {
    func setup(posterPath: String, title: String, isFavorite: Bool){
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: URL(string: AppConstants.API.imageBaseUrl + posterPath), placeholderImage: UIImage(named: "placeholder"))
        titleLabel.text = title
        if isFavorite {
            favoriteButton.setImage(UIImage(named: "star-filled")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
}
