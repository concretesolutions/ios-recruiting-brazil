//
//  FavoriteCell.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    let favoriteImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        title.textColor = .orange
        title.font = UIFont(name: Strings.fontProject, size: 18)
        return title
    }()
    
    let overViewLabel: UILabel = {
        let overview = UILabel(frame: .zero)
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.numberOfLines = 0
        overview.textColor = .white
        overview.font.withSize(13)
        return overview
    }()
    
    func setupCell(movie: Movie) {
        self.backgroundColor = .background
        let url = API.imageURL + (movie.backdropPath ?? "")

        if let url2 = URL(string: url) {
             favoriteImage.sd_setImage(with: url2, completed: nil)
        }
        
        self.titleLabel.text = movie.title
        self.overViewLabel.text = movie.overview
        setupConst()
    }

    func setupConst() {
        
        self.contentView.addSubview(favoriteImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(overViewLabel)
        
        favoriteImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        favoriteImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        favoriteImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        favoriteImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: favoriteImage.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        overViewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        overViewLabel.leadingAnchor.constraint(equalTo: favoriteImage.trailingAnchor, constant: 8).isActive = true
        overViewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        overViewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }

}
