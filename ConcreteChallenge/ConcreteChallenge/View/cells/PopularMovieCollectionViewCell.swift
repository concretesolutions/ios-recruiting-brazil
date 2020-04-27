//
//  PopularMovieCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 18/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit
import SDWebImage

class PopularMovieCollectionViewCell: UICollectionViewCell {
    
    var gl:CAGradientLayer!
    var movie: Movie!

    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var yearGenreLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wrapperView!.layer.cornerRadius = 10
        wrapperView.clipsToBounds = true
        
        let colorTop =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.0).cgColor
        let colorBottom = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.8]
        gradientLayer.frame = titleContainerView.bounds
        titleContainerView.backgroundColor = UIColor(white: 1, alpha: 0)
        titleContainerView.layer.insertSublayer(gradientLayer, at: 0)
        
        favoriteButton.imageEdgeInsets = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: -20)
    }

    func setup(with movie: Movie) {
        self.movie = movie
        
        if let posterPath = movie.posterPath {
            let url = URL(string: Constants.env.imageBaseUrl)?
                .appendingPathComponent("w500")
                .appendingPathComponent(posterPath)
            
            coverImageView!.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "placeholder.png")
            )
        }
        
        titleLabel.text = movie.title
        ratingLabel.text = String(format:"%.1f", movie.voteAverage / 2)
        
        var yearGenre = String(movie.releaseDate.prefix(4))
        if let genreName = movie.genres?.first {
            yearGenre += " - \(genreName)"
        }
        yearGenreLabel.text = yearGenre
        
        if movie.favorited {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.tintColor = UIColor.systemPink
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.tintColor = UIColor.darkGray
        }

    }
    @IBAction func favoriteToggle(_ sender: Any) {
        movie.toggleFavorite()
    }
}
