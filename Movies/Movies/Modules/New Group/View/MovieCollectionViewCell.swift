//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Renan Germano on 20/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    
    var movie: Movie!
    var presenter: MoviesPresentation!
    private let favoriteFullImage = UIImage(named: "favorite_full_icon")
    private let favoriteGrayImage = UIImage(named: "favorite_gray_icon")
    
    // MARK: - Util functions
    
    func set(movie: Movie) {
        
        self.movie = movie
        self.title.text = movie.title
        self.favoriteButton.addTarget(self, action: #selector(self.didTapFavoriteButton), for: UIControl.Event.touchUpInside)
        self.setFavoriteButtonImage()
        if let posterImage = movie.posterImage {
            self.poster.image = posterImage
        } else if movie.isFavorite {
            self.movie.posterImage = ImageDataManager.readImage(withPosterPath: movie.posterPath)
            self.poster.image = self.movie.posterImage
        } else {
            self.poster.showActivityIndicator()
            APIDataManager.readPosterImage(withCode: movie.posterPath) { image in
                DispatchQueue.main.async {
                    self.poster.hideActivityIndicator()
                    movie.posterImage = image ?? UIImage(named: "default")
                    self.poster.image = movie.posterImage
                }
            }
        }
    }
    
    @objc func didTapFavoriteButton() {
        self.presenter.didTapFavoriteButton(forMovie: self.movie)
        self.setFavoriteButtonImage()
    }
    
    private func setFavoriteButtonImage() {
        self.favoriteButton.setImage(self.movie.isFavorite ? self.favoriteFullImage : self.favoriteGrayImage, for: .normal)
    }
    
}
