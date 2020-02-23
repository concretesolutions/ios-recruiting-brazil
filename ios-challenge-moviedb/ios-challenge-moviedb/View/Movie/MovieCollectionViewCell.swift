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
        button.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var buttonBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(movieImage)
        contentView.addSubview(movieTitle)
        movieImage.addSubview(favoriteButton)
        favoriteButton.insertSubview(buttonBackground, aboveSubview: favoriteButton)
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

        // MARK: - Movie Title Constraint
        movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 5).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1).isActive = true
        
        // MARK: - Favorite Button Constraint
        favoriteButton.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 5).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -5).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 16.5).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 15.75).isActive = true
        
        // MARK: Favorite Button Background
        buttonBackground.centerXAnchor.constraint(equalTo: favoriteButton.centerXAnchor).isActive = true
        buttonBackground.centerYAnchor.constraint(equalTo: favoriteButton.centerYAnchor, constant: -1).isActive = true
        buttonBackground.widthAnchor.constraint(equalTo: favoriteButton.widthAnchor,multiplier: 1.3).isActive = true
        buttonBackground.heightAnchor.constraint(equalTo: favoriteButton.heightAnchor, multiplier: 1.3).isActive = true

    }
}
