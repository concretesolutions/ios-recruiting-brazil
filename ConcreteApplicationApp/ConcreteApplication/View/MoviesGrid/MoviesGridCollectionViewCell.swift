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
    var favoriteMovieDelegate: FavoriteMovieDelegate!
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var view: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoriteView: UIImageView = {
        let favoriteView = UIImageView(frame: .zero)
        favoriteView.translatesAutoresizingMaskIntoConstraints = false
        return favoriteView
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
        contentView.addSubview(view)
        contentView.addSubview(label)
        contentView.addSubview(favoriteView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //label
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: favoriteView.leadingAnchor),
            label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            //view
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            //imageView
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.label.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //favoriteView
            favoriteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            favoriteView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            favoriteView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    func setupAdditionalConfiguration() {
        
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = Design.Colors.darkYellow
        label.textAlignment = .center
        label.numberOfLines = 0
        
        view.backgroundColor = Design.Colors.darkBlue
        favoriteView.contentMode = .center
        
        //FIXME:- check if it is working properly after favorite a movie
        if movie.isFavorite{
            favoriteView.image = UIImage(named: "favorite_full_icon")
        }else{
            favoriteView.image = UIImage(named: "favorite_gray_icon")
        }
        
    }
    
}
