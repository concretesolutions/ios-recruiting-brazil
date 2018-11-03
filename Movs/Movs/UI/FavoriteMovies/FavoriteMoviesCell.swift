//
//  FavoriteMoviesCell.swift
//  Movs
//
//  Created by Gabriel Reynoso on 25/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class FavoriteMoviesCell: UITableViewCell {
    
    static let identifier:String = "CellReuseIdentifier:FavoriteMoviesCell"
    
    private var cellContentStack:UIStackView! {
        didSet {
            self.cellContentStack.axis = .vertical
            self.cellContentStack.alignment = .fill
            self.cellContentStack.distribution = .fill
            self.addSubview(self.cellContentStack)
        }
    }
    
    private var cellHeaderStack:UIStackView! {
        didSet {
            self.cellHeaderStack.axis = .horizontal
            self.cellHeaderStack.alignment = .fill
            self.cellHeaderStack.distribution = .fill
        }
    }
    
    private var movieImageView:UIImageView! {
        didSet {
            self.contentMode = .scaleAspectFill
            self.addSubview(self.movieImageView)
        }
    }
    
    private var movieTitleLabel:UILabel! {
        didSet {
            self.movieTitleLabel.textAlignment = .left
            self.movieTitleLabel.textColor = Colors.darkBlue.color
        }
    }
    
    private var movieYearLabel:UILabel! {
        didSet {
            self.movieYearLabel.textAlignment = .right
            self.movieYearLabel.textColor = Colors.darkBlue.color
        }
    }
    
    private var movieOverviewLabel:UILabel! {
        didSet {
            self.movieOverviewLabel.textAlignment = .left
            self.movieOverviewLabel.textColor = Colors.darkBlue.color
            self.movieOverviewLabel.numberOfLines = 0
        }
    }
    
    var settedUp: Bool = false
    
    func configure(with movie:MovieDetail) {
        self.setMovieImageView(image: Assets.searchIcon.image)
        ImageCache.global.getImage(for: movie.w185PosterPath) { img in
            self.setMovieImageView(image: img)
        }
        
        self.movieTitleLabel.text = movie.title
        self.movieYearLabel.text = movie.releaseYear
        self.movieOverviewLabel.text = movie.overview
    }
    
    func setMovieImageView(image:UIImage?) {
        self.movieImageView.image = image
    }
}


extension FavoriteMoviesCell: ReusableViewCode {
    
    func design() {
        self.movieImageView = UIImageView(image: nil)
        self.movieTitleLabel = UILabel(frame: .zero)
        self.movieYearLabel = UILabel(frame: .zero)
        self.movieOverviewLabel = UILabel(frame: .zero)
        self.cellHeaderStack = UIStackView(arrangedSubviews: [self.movieTitleLabel, self.movieYearLabel])
        self.cellContentStack = UIStackView(arrangedSubviews: [self.cellHeaderStack, self.movieOverviewLabel])
    }
    
    func autolayout() {
        // image view
        self.movieImageView.translatesAutoresizingMaskIntoConstraints = false
        self.movieImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.movieImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.movieImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.movieImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        // cell content stack
        self.cellContentStack.translatesAutoresizingMaskIntoConstraints = false
        self.cellContentStack.leftAnchor.constraint(equalTo: self.movieImageView.rightAnchor, constant: 5.0).isActive = true
        self.cellContentStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5.0).isActive = true
        self.cellContentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0).isActive = true
        self.cellContentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0).isActive = true
    }
}
