//
//  MovieCell.swift
//  Movies
//
//  Created by Jonathan Martins on 19/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit
import Foundation

class MovieCell: UICollectionViewCell{
    
    static let identifier = "MovieCell"
    
    // The cell's icon
    private let poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // The movie's name
    private let movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // The movie's release date
    private let movieDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Indicates if the movie is favorite
    private let favoriteIcon: UIImageView = {
        let icon   = UIImageView()
        icon.image = UIImage(named: "icon_favorite_over")
        icon.image = icon.image!.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.init(hexString: "#d32f2f")
        icon.contentMode = .scaleAspectFill
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    /// Adds the constraints to the views in this cell
    private func setupConstraints(){
        
        self.contentView.addSubview(poster)
        self.contentView.addSubview(movieName)
        self.contentView.addSubview(movieDate)
        self.contentView.addSubview(favoriteIcon)
        
        NSLayoutConstraint.activate([
            poster.heightAnchor  .constraint(equalToConstant: 200),
            poster.topAnchor     .constraint(equalTo: self.contentView.topAnchor, constant: 5),
            poster.leadingAnchor .constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            poster.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            
            favoriteIcon.widthAnchor   .constraint(equalToConstant: 20),
            favoriteIcon.heightAnchor  .constraint(equalToConstant: 20),
            favoriteIcon.bottomAnchor  .constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            favoriteIcon.trailingAnchor.constraint(equalTo: poster.trailingAnchor, constant: -5),
            
            movieName.topAnchor     .constraint(equalTo: self.poster.bottomAnchor, constant: 5),
            movieName.leadingAnchor .constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            movieName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            
            movieDate.bottomAnchor  .constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            movieDate.leadingAnchor .constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            movieDate.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.addDropShadow()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configures the Cell
    func setupCell(movie:Movie){

        /// Sets the name of the cell
        movieName.text = movie.title
        
        /// Sets the release date of the cell
        movieDate.text = movie.releaseDate.formatDate(fromPattern: "yyyy-mm-dd", toPattern: "d MMMM yyyy")
        
        /// Sets the icon of the cell
        if let url = movie.poster{
            poster.load(url)
        }
        
        /// Hides or shows the favorite icon
        let isFavorite = User.current.isMovieFavorite(movie: movie)
        favoriteIcon.isHidden = !isFavorite
    }
}

