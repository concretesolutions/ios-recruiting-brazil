//
//  PopularMoviesTableViewCell.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 12/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import UIKit

class PopularMoviesTableViewCell: UITableViewCell {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var indicatorOfActivity: UIActivityIndicatorView!
    
    //MARK: - SUPER METHODS
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configure(with: .none)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorOfActivity.hidesWhenStopped = true
    }
    
    //MARK: - METHODS
    
    func configure(with movie: FavoriteMovies?) {

        if let movie = movie {
            titleLabel.text = movie.title
            descriptionLabel.text = movie.description
            titleLabel.alpha = 1
            descriptionLabel.alpha = 1
            indicatorOfActivity.stopAnimating()
            posterImage.loadImageFromURLString(urlStirng: movie.posterPath)
        } else {
            titleLabel.alpha = 1
            //yearLabel.alpha = 1
            descriptionLabel.alpha = 1
            indicatorOfActivity.startAnimating()
        }
    }
    
    func convertDateFormat(input: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: input)
        dateFormatter.dateFormat = "yyyy"
        guard let returnDate = date else { return "" }
        return dateFormatter.string(from: returnDate)
    }
}
