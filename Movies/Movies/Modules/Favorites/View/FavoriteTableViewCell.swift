//
//  FavoriteTableViewCell.swift
//  Movies
//
//  Created by Renan Germano on 23/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    // MARK: - Properties
    
    var movie: Movie!
    
    // MARK: - Util functions
    
    func set(movie: Movie) {
        self.poster.image = movie.posterImage
        self.movie = movie
        self.year.text = "\(movie.year)"
        self.overview.text = movie.overview
    }
    

}
