//
//  NameTableViewCell.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 21/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    var isFavorite = false
    var movie = Movie()
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func setFavorite(_ sender: Any) {
        if isFavorite {
            PersistenceService.removeFavorite(withName: movie.name)
            favoriteButton.setImage(#imageLiteral(resourceName: "favorite_empty_icon"), for: .normal)
            isFavorite = !isFavorite
        } else {
            PersistenceService.saveFavoriteMovie(movie: movie)
            favoriteButton.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
            isFavorite = !isFavorite
        }
    }
    
    

}
