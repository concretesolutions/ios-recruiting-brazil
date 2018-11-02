//
//  MoviesGridCell.swift
//  Movs
//
//  Created by Gabriel Reynoso on 23/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

// MARK: - Collection view cell

final class MoviesGridCell: UICollectionViewCell {
    
    static let identifier:String = "CellReuseIdentififer:MoviesGridCell"
    
    private var movieImageView:UIImageView! {
        didSet {
            self.movieImageView.contentMode = .scaleAspectFit
            self.addSubview(self.movieImageView)
        }
    }
    
    private var movieTitleLabel:UILabel! {
        didSet {
            self.movieTitleLabel.textColor = Colors.mainYellow.color
            self.movieTitleLabel.textAlignment = .center
            self.addSubview(self.movieTitleLabel)
        }
    }
    
    private var favoriteButton:FavoriteButton! {
        didSet {
            self.addSubview(self.favoriteButton)
        }
    }
    
    var settedUp:Bool = false
    
    func configure(with movie: Movie, and image:UIImage?) {
        self.movieImageView.image = image
        self.movieTitleLabel.text = movie.title
        self.favoriteButton.isSelected = movie.isFavorite
    }
}

extension MoviesGridCell: ReusableViewCode {
    
    func design() {
        self.backgroundColor = Colors.darkBlue.color
        self.movieImageView = UIImageView()
        self.movieTitleLabel = UILabel()
        self.favoriteButton = FavoriteButton()
    }
    
    func autolayout() {
        // movie image
        self.movieImageView.translatesAutoresizingMaskIntoConstraints = false
        self.movieImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.movieImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.movieImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        self.movieImageView.bottomAnchor.constraint(equalTo: self.movieTitleLabel.topAnchor, constant: -5.0).isActive = true
        // movie title
        self.movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.movieTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5.0).isActive = true
        self.movieTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 5.0).isActive = true
        self.movieTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        self.movieTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0).isActive = true
        // movie is favorite indicator
        self.favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.favoriteButton.heightAnchor.constraint(equalTo: self.movieTitleLabel.heightAnchor).isActive = true
        self.favoriteButton.widthAnchor.constraint(equalTo: self.favoriteButton.heightAnchor).isActive = true
        self.favoriteButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5.0).isActive = true
        self.favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0).isActive = true
    }
}
