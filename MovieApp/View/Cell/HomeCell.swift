//
//  HomeCell.swift
//  MovieApp
//
//  Created by Mac Pro on 27/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var topoIv: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(movie: Movie){
    
        topoIv.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"), completed: nil)
        titleLb.text = movie.title
        
    }

}
