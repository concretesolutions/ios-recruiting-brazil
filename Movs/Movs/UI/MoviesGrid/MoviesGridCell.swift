//
//  MoviesGridCell.swift
//  Movs
//
//  Created by Gabriel Reynoso on 23/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

// MARK: - Collection view cell

final class MoviesGridCell: UICollectionViewCell, ViewCode {
    
    static let identifier:String = "CellReuseIdentififer:MoviesGridCell"
    
    private let movieImageView:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let movieTitleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let movieIsFavoriteIndicatorButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(nil, for: .normal)
        button.setImage(Assets.favoriteGrayIcon.image, for: .normal)
        button.setImage(Assets.favoriteFillIcon.image, for: .selected)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.addSubview(self.movieImageView)
        self.addSubview(self.movieTitleLabel)
        self.addSubview(self.movieIsFavoriteIndicatorButton)
        self.setup()
    }
    
    func design() {
    }
    
    func autolayout() {
        // movie image
        self.movieImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
        self.movieImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
        self.movieImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        self.movieImageView.bottomAnchor.constraint(equalTo: self.movieTitleLabel.topAnchor, constant: 0.0).isActive = true
        // movie title
        self.movieTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
        self.movieTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
        self.movieTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        self.movieTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
        // movie is favorite indicator
        self.movieIsFavoriteIndicatorButton.heightAnchor.constraint(equalTo: self.movieTitleLabel.heightAnchor, multiplier: 1.0).isActive = true
        self.movieIsFavoriteIndicatorButton.widthAnchor.constraint(equalTo: self.movieIsFavoriteIndicatorButton.heightAnchor, multiplier: 1.0).isActive = true
        self.movieIsFavoriteIndicatorButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
        self.movieIsFavoriteIndicatorButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
    }
    
    func setup(with data: Data) {
        self.movieImageView.image = data.movieImage
        self.movieTitleLabel.text = data.movieTitle
        self.movieIsFavoriteIndicatorButton.isSelected = data.movieIsFavorite
    }
    
    struct Data {
        let movieImage:UIImage
        let movieTitle:String
        var movieIsFavorite:Bool
    }
}
