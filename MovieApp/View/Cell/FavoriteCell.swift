//
//  FavoriteCell.swift
//  MovieAppTests
//
//  Created by Mac Pro on 30/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var yearLb: UILabel!
    
    @IBOutlet weak var overviewLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCell(movie: MovieFavorite){
        
        imageViewPoster.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movie.url!)"), completed: nil)
        titleLb.text = movie.title
        yearLb.text = movie.year
        overviewLb.text = movie.overview
        print("https://image.tmdb.org/t/p/w500\(movie.url!)")
    }
    
}
