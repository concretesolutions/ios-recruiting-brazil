//
//  FavoriteTableViewCell.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 24/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    
    let identiifier = "FavoriteTableViewCell"
    
    var movie: MovieCoreData? {
        didSet {
            configure()
        }
    }
    
    private func configure(){
        
        guard let movie = movie else { return }
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            let date = movie.releaseDate?.split(separator: "-").first
            self.dateLabel.text = String(date!)
            self.overviewTextView.text = movie.overview
            if let imageUrlString = movie.posterPath {
                self.movieImageView.downloaded(from: imageUrlString, contentMode: .scaleToFill)
            }
        }
    }
    
}
