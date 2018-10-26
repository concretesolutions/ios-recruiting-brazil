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
    
    struct Data {
        let movieImage:UIImage
        let movieTitle:String
        var movieIsFavorite:Bool
    }
    
    static let identifier:String = "CellReuseIdentififer:MoviesGridCell"
    
    private let movieImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let movieTitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = Colors.mainYellow.color
        label.textAlignment = .center
        return label
    }()
    
    private let movieIsFavoriteIndicatorButton:UIButton = {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        button.setImage(Assets.favoriteGrayIcon.image, for: .normal)
        button.setImage(Assets.favoriteFillIcon.image, for: .selected)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    var settedUp:Bool = false
    
    func configure(with data: Data) {
        self.movieImageView.image = data.movieImage
        self.movieTitleLabel.text = data.movieTitle
        self.movieIsFavoriteIndicatorButton.isSelected = data.movieIsFavorite
    }
}

extension MoviesGridCell: ReusableViewCode {
    
    func design() {
        self.backgroundColor = Colors.darkBlue.color
        self.addSubview(self.movieImageView)
        self.addSubview(self.movieTitleLabel)
        self.addSubview(self.movieIsFavoriteIndicatorButton)
    }
    
    func autolayout() {
        // movie image
        self.movieImageView.translatesAutoresizingMaskIntoConstraints = false
        self.movieImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.movieImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.movieImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.movieImageView.bottomAnchor.constraint(equalTo: self.movieTitleLabel.topAnchor).isActive = true
        // movie title
        self.movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.movieTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.movieTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.movieTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        self.movieTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        // movie is favorite indicator
        self.movieIsFavoriteIndicatorButton.translatesAutoresizingMaskIntoConstraints = false
        self.movieIsFavoriteIndicatorButton.heightAnchor.constraint(equalTo: self.movieTitleLabel.heightAnchor).isActive = true
        self.movieIsFavoriteIndicatorButton.widthAnchor.constraint(equalTo: self.movieIsFavoriteIndicatorButton.heightAnchor).isActive = true
        self.movieIsFavoriteIndicatorButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.movieIsFavoriteIndicatorButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
