//
//  FavoriteMoviesCell.swift
//  Movs
//
//  Created by Gabriel Reynoso on 25/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class FavoriteMoviesCell: UITableViewCell {
    
    struct Data {
        let movieImage:UIImage
        let movieTitle:String
        let movieYear:String
        let movieDescription:String
    }
    
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
    
    private var movieDescriptionLabel:UILabel! {
        didSet {
            self.movieDescriptionLabel.textAlignment = .left
            self.movieDescriptionLabel.textColor = Colors.darkBlue.color
            self.movieDescriptionLabel.numberOfLines = 0
        }
    }
    
    var settedUp: Bool = false
    
    func configure(with data:Data) {
        self.movieImageView.image = data.movieImage
        self.movieTitleLabel.text = data.movieTitle
        self.movieYearLabel.text = data.movieYear
        self.movieDescriptionLabel.text = data.movieDescription
    }
}


extension FavoriteMoviesCell: ReusableViewCode {
    
    func design() {
        self.movieImageView = UIImageView(image: nil)
        self.movieTitleLabel = UILabel(frame: .zero)
        self.movieYearLabel = UILabel(frame: .zero)
        self.movieDescriptionLabel = UILabel(frame: .zero)
        self.cellHeaderStack = UIStackView(arrangedSubviews: [self.movieTitleLabel, self.movieYearLabel])
        self.cellContentStack = UIStackView(arrangedSubviews: [self.cellHeaderStack, self.movieDescriptionLabel])
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
        self.cellContentStack.leftAnchor.constraint(equalTo: self.movieImageView.rightAnchor).isActive = true
        self.cellContentStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.cellContentStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.cellContentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
