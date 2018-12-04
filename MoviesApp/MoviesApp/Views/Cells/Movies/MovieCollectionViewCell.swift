//
//  MovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 03/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import SDWebImage

protocol MovieCollectionViewCellDelegateProtocol: NSObjectProtocol {
    func favoriteTapped(at cell: MovieCollectionViewCell)
}

class MovieCollectionViewCell: UICollectionViewCell {
    class var reuseIdentifier: String {
        return "MovieCollectionViewCell"
    }

    class var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.sd_cancelCurrentAnimationImagesLoad()
    }

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    private weak var activityIndicator: UIActivityIndicatorView?
    
    weak var delegate: MovieCollectionViewCellDelegateProtocol?

    func set(_ movie: Movie) {
        if movie.title.split(separator: " ").count > 1 {
            titleLabel.numberOfLines = 2
        } else {
            titleLabel.numberOfLines = 1
        }
        titleLabel.text = movie.title
        favoriteButton.isSelected = movie.isFavorite
        pictureImageView
            .sd_setImage(with: ImageServiceConfig
                .defaultURL(with: movie.posterPath,
                            width: Int(self.pictureImageView.frame.size.width))) { (image, _, _, _) in
            if let image = image {
                self.pictureImageView.image = image.proportionalResized(width: self.pictureImageView.frame.size.width)
            }
        }
    }

    @IBAction func favoriteTapped(_ sender: Any) {
        favoriteButton.isSelected = !favoriteButton.isSelected
        self.delegate?.favoriteTapped(at: self)
    }
}
