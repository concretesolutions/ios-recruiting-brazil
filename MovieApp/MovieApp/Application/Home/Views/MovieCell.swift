//
//  MovieCell.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//


import UIKit
import SDWebImage

protocol MovieCellDelegate: class {
    
    func tapped(index: Int)
}

class MovieCell: UICollectionViewCell {
    
    var movie: Movie?
    var index: Int?
    weak var delegate: MovieCellDelegate?

    let imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        title.textColor = .white
        return title
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "icons8-like"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "icons8-like_filled"), for: .selected)
        return button
    }()
    
    let viewBackground: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return view
    }()
    
    func setupCell(movie: Movie, index: Int, isFavorite: Bool) {
        
        self.movie = movie
        self.index = index
        self.titleLabel.text = movie.title
        let url = API.imageURL + (movie.posterPath ?? "")
        if let url2 = URL(string: url) {
             imageView.sd_setImage(with: url2, completed: nil)
        }
        favoriteButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        favoriteButton.isSelected = isFavorite
        setupLayout()
    }
    
    func setupLayout() {
        
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(viewBackground)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(favoriteButton)
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        titleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor,constant: -10).isActive = true
        
        favoriteButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8).isActive = true
        favoriteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        
        viewBackground.heightAnchor.constraint(equalToConstant: 70).isActive = true
        viewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        viewBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        viewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    @objc func tappedButton() {
        delegate?.tapped(index: self.index ?? 0)
        
    }
}


