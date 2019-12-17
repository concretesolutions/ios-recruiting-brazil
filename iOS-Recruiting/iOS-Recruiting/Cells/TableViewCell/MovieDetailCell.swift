//
//  MovieDetailCell.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 17/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    internal func configure(_ movie: Movie?) {
        if let poster = movie?.poster_path, let url = NetworkService.getURL(api: .imagesMovieDB, path: poster) {
           self.posterImageView.setImage(url: url)
       }
        
        self.titleLabel.text = movie?.original_title
        self.descriptionLabel.text = movie?.overview
        self.yearLabel.text = movie?.release_date?.split{$0 == "-"}.map(String.init).first
    }
    
}

extension MovieDetailCell: ReusableView, NibLoadableView {}
