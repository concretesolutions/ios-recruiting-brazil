//
//  MovieCollectionViewCell.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    static let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
    static let identifier = "MovieCollectionViewCellID"
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepareCell(movie: MovieData) {
        self.movieImageView.sd_setImage(with: movie.posterPath.toImageUrl(), completed: nil)
        self.titleLabel.text = movie.originalTitle
        self.favoriteButton.isSelected = DBManager.sharedInstance.moveIsFavored(movieId: movie.id)
    }
}
