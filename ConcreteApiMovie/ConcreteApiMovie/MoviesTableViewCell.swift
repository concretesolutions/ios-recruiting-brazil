//
//  MoviesTableViewCell.swift
//  ConcreteApiMovie
//
//  Created by Israel3D on 18/09/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovie: UILabel!
    @IBOutlet weak var imgFavorited: UIImageView!
    
    var moviesIds: [Int] = []
    
    func prepareCell(withMovie movie:MoviesResults) {
        lblMovie.text = movie.title
        moviesIds = FavoritesUserDefaults().showFavoritesMovie()
        
        imgFavorited.image = (moviesIds.contains(movie.id)) ? #imageLiteral(resourceName: "favorite_full_icon") : #imageLiteral(resourceName: "favorite_empty_icon")
        
        if let url = URL(string: movie.urlImage) {
            imgMovie.kf.indicatorType = .activity
            imgMovie.kf.setImage(with: url)
        } else {
            imgMovie.image = nil
        }
        
        imgMovie.layer.cornerRadius = imgMovie.frame.size.height/2
        imgMovie.layer.borderWidth = 2
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
