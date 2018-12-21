//
//  MoviesGridCollectionViewCell.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage

class MoviesGridCollectionViewCell: UICollectionViewCell, Reusable {
    
    var movie: Movie!
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setup(movie: Movie){
        self.movie = movie
        setupView()
        imageView.downloadImage(with: movie.posterPath ?? "")
        label.text = movie.title
    }
}

extension MoviesGridCollectionViewCell: CodeView{
    func buildViewHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.label.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
    
    func setupAdditionalConfiguration() {
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.backgroundColor = Design.Colors.darkBlue
        label.textColor = Design.Colors.darkYellow
        label.textAlignment = .center
        label.numberOfLines = 0
    }
    
    
}
