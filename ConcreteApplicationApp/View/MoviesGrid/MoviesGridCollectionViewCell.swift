//
//  MoviesGridCollectionViewCell.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import Reusable

class MoviesGridCollectionViewCell: UICollectionViewCell, Reusable {
    
    var movie: Movie!
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setup(movie: Movie){
        self.movie = movie
        setupView()
        imageView.downloadImage(with: movie.posterPath ?? "")
    }
}

extension MoviesGridCollectionViewCell: CodeView{
    func buildViewHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        //FIXME:- try it with SnapKit
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
    
    
}
