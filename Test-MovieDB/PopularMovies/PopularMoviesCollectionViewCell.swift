//
//  PopularMoviesCollectionViewCell.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 13/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import UIKit

class PopularMoviesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameOfMovieLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var indicatorOfActivity: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        configure(with: .none, searchData: .none)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        indicatorOfActivity.hidesWhenStopped = true
    }
    
    func configure(with movie: PopularResults?, searchData: ResultsOfSearchWorker?) {
        if let movie = movie {
            nameOfMovieLabel.text = movie.title
            nameOfMovieLabel.textColor = Colors.darkYellow.color
            nameOfMovieLabel.alpha = 1
            indicatorOfActivity.stopAnimating()
            posterImage.loadImageFromURLString(urlStirng: movie.poster_path)
        } else if let searchData = searchData {
            nameOfMovieLabel.text = searchData.title
            nameOfMovieLabel.textColor = Colors.darkYellow.color
            nameOfMovieLabel.alpha = 1
            indicatorOfActivity.stopAnimating()
            posterImage.loadImageFromURLString(urlStirng: searchData.poster_path)
        } else {
            nameOfMovieLabel.alpha = 1
            posterImage.alpha = 1
            indicatorOfActivity.startAnimating()
            
        }
    }
}
