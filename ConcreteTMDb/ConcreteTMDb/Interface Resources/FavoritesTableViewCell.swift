//
//  FavoritesTableViewCell.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 23/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var OutletFavoriteMovieImage: UIImageView!
    @IBOutlet weak var OutletFavoriteMovieName: UILabel!
    @IBOutlet weak var OutletFavoriteMovieYear: UILabel!
    @IBOutlet weak var OutletFavoriteMovieDescription: UILabel!
    
    // MARK: - Properties
    
    var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(movie: Movie) {
        self.movie = movie
        self.OutletFavoriteMovieName.text = movie.title
        self.OutletFavoriteMovieYear.text = movie.date
        self.OutletFavoriteMovieDescription.text = movie.overview
        self.OutletFavoriteMovieImage.image = movie.image
    }

}
