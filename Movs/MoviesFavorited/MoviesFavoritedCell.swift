//
//  MoviesFavoritedCell.swift
//  Movs
//
//  Created by Rafael Douglas on 20/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit

class MoviesFavoritedCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var moviesFavoritedPoster: UIImageView!
    @IBOutlet weak var moviesFavoritedTitle: UILabel!
    @IBOutlet weak var moviesFavoritedOverview: UILabel!
    
    func prepare(with movie: Movies){
        if let path = movie.poster_path {
            let url = URL(string: API_MOVIEDB_URL_IMAGE_BASE + path)!
            moviesFavoritedPoster.af_setImage(withURL: url)
        }
        if let title = movie.title {
            self.moviesFavoritedTitle.text = title
        }
        if let overview = movie.overview {
            self.moviesFavoritedOverview.text = overview
        }
    }
}
