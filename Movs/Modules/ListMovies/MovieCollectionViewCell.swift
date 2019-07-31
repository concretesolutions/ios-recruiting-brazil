//
//  MovieCollectionViewCell.swift
//  DesafioConcrete_BrunoChagas
//
//  Created by Bruno Chagas on 24/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet var poster: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var favoriteIcon: UIImageView!
    
    //MARK: - Initialization
    override func awakeFromNib() {
        
        adjustConstraints()
        self.backgroundColor = ColorPalette.darkYellow.uiColor
        movieTitle.textColor = ColorPalette.textBlack.uiColor
        movieTitle.textAlignment = .left
        
        favoriteIcon.image = nil
        
        poster.image = poster.image?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
    }
    
    //MARK: - Functions
    func adjustConstraints() {
        poster.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        favoriteIcon.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Poster contraints
        if let poster = self.poster {
            self.addConstraints([
                NSLayoutConstraint(item: poster, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: poster, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0),
                //NSLayoutConstraint(item: poster, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: poster, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: poster, attribute: .height, relatedBy: .equal, toItem: poster, attribute: .width, multiplier: 1.0, constant: 0)
                
                ])
        }
        
        //MARK: Movie title contraints
        if let movieTitle = self.movieTitle {
            self.addConstraints([
                NSLayoutConstraint(item: movieTitle, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10),
                NSLayoutConstraint(item: movieTitle, attribute: .trailing, relatedBy: .equal, toItem: favoriteIcon, attribute: .leading, multiplier: 1.0, constant: -10),
                NSLayoutConstraint(item: movieTitle, attribute: .top, relatedBy: .equal, toItem: poster, attribute: .bottom, multiplier: 1.0, constant: 5),
                NSLayoutConstraint(item: movieTitle, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -5)
                
                ])
        }
        
        //MARK: Favorite icon contraints
        if let favoriteIcon = self.favoriteIcon {
            self.addConstraints([
                NSLayoutConstraint(item: favoriteIcon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 20),
                NSLayoutConstraint(item: favoriteIcon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 20),
                NSLayoutConstraint(item: favoriteIcon, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10),
                NSLayoutConstraint(item: favoriteIcon, attribute: .centerY, relatedBy: .equal, toItem: movieTitle, attribute: .centerY, multiplier: 1.0, constant: 0)
                
                ])
        }
        
        self.updateConstraints()
    }
    
    func populate(with movie: MovieEntity, poster: PosterEntity?) {
        if let photo = poster?.poster {
            self.poster.image = photo
        }
        
        if let name = movie.title {
            self.movieTitle.text = name
        }
        
        if UserSaves.isFavorite(movie: movie) {
            self.favoriteIcon.image = UIImage(imageLiteralResourceName: "favorite_gray_icon")
        }
        else {
            self.favoriteIcon.image = nil
        }
    }
    
}
