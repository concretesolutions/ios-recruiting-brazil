//
//  FavoriteCell.swift
//  Movs
//
//  Created by Alexandre Papanis on 30/03/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var lbMovieYear: UILabel!
    @IBOutlet weak var lbGenres: UILabel!
    @IBOutlet weak var lbMovieDescription: UILabel!
    
    var favoriteMovie: FavoriteMovie! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI(){
        lbMovieTitle.text = favoriteMovie.title
        lbMovieYear.text = favoriteMovie.year
        lbMovieDescription.text = favoriteMovie.overview
        lbGenres.text = favoriteMovie.genres
        if let coverPath = favoriteMovie.coverPath {
            imgMovie.sd_setImage(with: URL(string: Defines.baseImageURL + coverPath), completed: nil)
        } else {
            imgMovie.image = UIImage(named: "no-movies")
        }
    }
    
}
