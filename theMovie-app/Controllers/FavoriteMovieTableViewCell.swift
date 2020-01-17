//
//  FavoriteMovieTableViewCell.swift
//  theMovie-app
//
//  Created by Adriel Alves on 07/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var uiMoviePoster: UIImageView!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbMovieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func prepare(with favoriteMovie: FavoriteMovieData) {
        
        lbMovieTitle.text = favoriteMovie.movieTitle
        lbYear.text = favoriteMovie.movieYear
        lbDescription.text = favoriteMovie.movieDetails
        
        if let image = favoriteMovie.moviePoster as? UIImage {
            uiMoviePoster.image = image
        } else {
            uiMoviePoster.image = UIImage(named: "images")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lbMovieTitle.text = "----"
        lbYear.text = "0000"
        uiMoviePoster.image = UIImage.init(named: "images")
        
    }

}
