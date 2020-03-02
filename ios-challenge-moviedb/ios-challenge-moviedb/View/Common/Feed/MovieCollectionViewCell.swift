//
//  MovieCollectionViewCell.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 22/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .white
        label.font = .systemFont(ofSize: 11)
        return label
    }()
    
    var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Constants.FavoriteButton.imageNamedNormal), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(movieImage)
        contentView.addSubview(movieTitle)
        contentView.addSubview(favoriteButton)
        self.isUserInteractionEnabled = true
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        // MARK: - Movie Image Constraint
        movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        movieImage.widthAnchor.constraint(equalToConstant: Constants.MovieCollectionView.estimatedCellWidth).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: Constants.MovieCollectionView.estimatedCellHeight).isActive = true
        
        // MARK: - Favorite Button Constraint
        favoriteButton.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 5).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 16.5).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 15.75).isActive = true

        // MARK: - Movie Title Constraint
        movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 5).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -2).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1).isActive = true
    }
}
