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
    
//    var movieTitle: UILabel
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(movieImage)
        self.isUserInteractionEnabled = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
//        movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        movieImage.widthAnchor.constraint(equalToConstant: Constants.MovieCollectionView.estimatedCellWidth).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: Constants.MovieCollectionView.estimatedCellHeight).isActive = true
    }
}
