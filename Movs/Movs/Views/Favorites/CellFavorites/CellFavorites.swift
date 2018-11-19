//
//  CellFavorites.swift
//  Movs
//
//  Created by Victor Rodrigues on 17/11/18.
//  Copyright © 2018 Victor Rodrigues. All rights reserved.
//

import UIKit
import Kingfisher

class CellFavorites: UITableViewCell {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var nameMovieLbl: UILabel!
    @IBOutlet weak var dateMovieLbl: UILabel!
    @IBOutlet weak var overviewMovieText: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageMovie.layer.cornerRadius = 5
        imageMovie.layer.masksToBounds = true
        
    }
    
    func config(favorited: [Favorites], at index: Int) {
        let item = favorited.reversed()[index]
        
        if let imageUrl = item.poster_path, let titleMovie = item.title,
            let date = item.release_date, let overview = item.overview {
            dateMovieLbl.text = "\(date)"
            nameMovieLbl.text = "\(titleMovie)"
            overviewMovieText.text = "\(overview)"
            imageMovie.kf.setImage(with: URL(string: Network.shared.imageUrl + imageUrl))
        }
        
    }
    
}
