//
//  FavoriteMovieTableViewCell.swift
//  DesafioConcrete_BrunoChagas
//
//  Created by Bruno Chagas on 24/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var releaseYear: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var poster: UIImageView!
    
    //MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        adjustConstraints()
        
        self.backgroundColor = .clear
        
        poster.image = poster.image?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
    }

    //MARK: - Functions
    func populate(with movie: MovieEntity, poster: PosterEntity?) {
        if let photo = poster?.poster {
            self.poster.image = photo
        }
        
        if let name = movie.title {
            self.movieTitle.text = name
        }
        
        if let desc = movie.movieDescription {
            self.descriptionLabel.text = desc
        }
        
        if movie.releaseDate != nil {
            self.releaseYear.text = movie.formatDateString()
        }

    }
    
    func adjustConstraints() {
        poster.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        releaseYear.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        //MARK: Poster constraints
        if let poster = self.poster {
            self.addConstraints([
                NSLayoutConstraint(item: poster, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 5),
                NSLayoutConstraint(item: poster, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 5),
                NSLayoutConstraint(item: poster, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -5),
                NSLayoutConstraint(item: poster, attribute: .width, relatedBy: .equal, toItem: poster, attribute: .height, multiplier: 1.0, constant: 0)
                ])
        }
        
        //MARK: Movie title constraints
        if let movieTitle = self.movieTitle {
            self.addConstraints([
                NSLayoutConstraint(item: movieTitle, attribute: .leading, relatedBy: .equal, toItem: poster, attribute: .trailing, multiplier: 1.0, constant: 10),
                NSLayoutConstraint(item: movieTitle, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10),
                NSLayoutConstraint(item: movieTitle, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30),
                NSLayoutConstraint(item: movieTitle, attribute: .trailing, relatedBy: .equal, toItem: releaseYear, attribute: .leading, multiplier: 1.0, constant: -10)
                ])
        }
        
        //MARK: Release year constraints
        if let releaseYear = self.releaseYear {
            self.addConstraints([
                NSLayoutConstraint(item: releaseYear, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10),
                NSLayoutConstraint(item: releaseYear, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10),
                NSLayoutConstraint(item: releaseYear, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 60),
                NSLayoutConstraint(item: releaseYear, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 25)
                ])
        }
        
        //MARK: Description label constraints
        if let descriptionLabel = self.descriptionLabel {
            self.addConstraints([
                NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: poster, attribute: .trailing, multiplier: 1.0, constant: 10),
                NSLayoutConstraint(item: descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10),
                NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: movieTitle, attribute: .bottom, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: descriptionLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -5)
                ])
        }
        
        self.updateConstraints()
    }
}
