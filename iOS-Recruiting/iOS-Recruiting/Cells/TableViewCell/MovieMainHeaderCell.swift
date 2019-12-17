//
//  MovieMainHeaderCell.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 17/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import UIKit

protocol MovieHeaderDelegate: UIViewController {
    func setFavourite(movie: Movie?)
}
class MovieMainHeaderCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var favouriteIconButton: UIButton!
    
    internal weak var delegate: MovieHeaderDelegate?
    
    private(set) var movie: Movie?
    
    internal func configure(_ movie: Movie?) {
        self.movie = movie
        self.nameLabel.text = movie?.original_title
        
        if let poster = movie?.poster_path, let url = NetworkService.getURL(api: .imagesMovieDB, path: poster) {
            self.posterImageView.setImage(url: url)
        }
        
        self.favouriteIconButton.isHighlighted = movie?.isFavourite ?? false
    }
    
    @IBAction func favouriteTapped(_ sender: UIButton) {
        self.delegate?.setFavourite(movie: self.movie)
    }
}



extension MovieMainHeaderCell: ReusableView, NibLoadableView {}
