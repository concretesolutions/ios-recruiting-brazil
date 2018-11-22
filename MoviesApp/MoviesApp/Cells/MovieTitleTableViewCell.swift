//
//  MovieInfoTableViewCell.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 18/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit
import Reusable

class MovieTitleTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movie:Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setFavoriteButton(hasFavorited:Bool){
        if hasFavorited{
            self.favoriteButton.setImage(UIImage.favorite.fullHeart, for: .normal)
        }else{
            self.favoriteButton.setImage(UIImage.favorite.grayHeart, for: .normal)
        }
    }
    
    func setup(with movie:Movie){
        self.label.font = self.label.font.withSize(20.0)
        self.label.text = movie.title
        self.movie = movie
        self.setFavoriteButton(hasFavorited: CDMovieDAO.hasFavoriteMovie(with: movie.id))
    }
    
    @IBAction func tapFavoriteButton(_ sender: Any) {
        if let movie = self.movie{
            CDMovieDAO.create(from: movie)
            self.setFavoriteButton(hasFavorited: true)
        }
    }
    
    
}
