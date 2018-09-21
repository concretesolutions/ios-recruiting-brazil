//
//  FavoritesTableViewCell.swift
//  ConcreteApiMovie
//
//  Created by Israel3D on 20/09/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit
import Kingfisher

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFavoriteMovie: UIImageView!
    @IBOutlet weak var lblFavoriteMovie: UILabel!
    @IBOutlet weak var lblFavoriteYear: UILabel!
    @IBOutlet weak var lblFavoriteOverview: UILabel!
    
    func prepareCell(withMovie movie:MoviesResults) {
        lblFavoriteMovie.text = movie.title
        lblFavoriteYear.text = String(movie.release_date.prefix(4))
        lblFavoriteOverview.text = movie.overview
        
        if let url = URL(string: movie.urlImage) {
            imgFavoriteMovie.kf.indicatorType = .activity
            imgFavoriteMovie.kf.setImage(with: url)
        } else {
            imgFavoriteMovie.image = nil
        }
        
        imgFavoriteMovie.layer.cornerRadius = imgFavoriteMovie.frame.size.height/2
        imgFavoriteMovie.layer.borderWidth = 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
