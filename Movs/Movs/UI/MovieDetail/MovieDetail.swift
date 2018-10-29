//
//  MovieDetail.swift
//  Movs
//
//  Created by Gabriel Reynoso on 29/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MovieDetail: UIView {
    
    struct Data {
        let movieImage:UIImage
        let movieTitle:String
        let movieYear:String
        let movieGenre:String
        let movieDescription:String
        var isFavorite:Bool
    }
    
    private var contentStack:UIStackView! {
        didSet {
            
        }
    }
    
    private var titleStack:UIStackView! {
        didSet {
            
        }
    }
    
    private var imageView:UIImageView! {
        didSet {
            
        }
    }
    
    private var titleLabel:UILabel! {
        didSet {
            
        }
    }
    
    private var favoriteButton:UIButton! {
        didSet {
            
        }
    }
    
    private var yearLabel:UILabel! {
        didSet {
            
        }
    }
    
    private var genreLabel:UILabel! {
        didSet {
            
        }
    }
    
    private var descriptionLabel:UILabel! {
        didSet {
            
        }
    }
    
    var data: Data! {
        didSet {
            self.imageView.image = self.data.movieImage
            self.titleLabel.text = self.data.movieTitle
            self.favoriteButton.isSelected = self.data.isFavorite
            self.yearLabel.text = self.data.movieYear
            self.genreLabel.text = self.data.movieGenre
            self.descriptionLabel.text = self.data.movieDescription
        }
    }
}

extension MovieDetail: ViewCode {
    
    func design() {
        self.imageView = UIImageView(image: nil)
        self.titleLabel = UILabel(frame: .zero)
        self.favoriteButton = UIButton()
        self.yearLabel = UILabel(frame: .zero)
        self.genreLabel = UILabel(frame: .zero)
        self.descriptionLabel = UILabel(frame: .zero)
        
        self.titleStack = UIStackView(arrangedSubviews: [self.titleLabel, self.favoriteButton])
        self.contentStack = UIStackView(arrangedSubviews: [self.imageView, self.titleStack, self.yearLabel, self.genreLabel, self.descriptionLabel])
    }
    
    func autolayout() {
        self.contentStack.fillAvailableSpaceInSafeArea()
    }
}
