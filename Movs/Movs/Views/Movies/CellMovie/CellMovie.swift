//
//  CellMovie.swift
//  Movs
//
//  Created by Victor Rodrigues on 16/11/18.
//  Copyright © 2018 Victor Rodrigues. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class CellMovie: UICollectionViewCell {

    @IBOutlet weak var viewIsFavoritedBtn: UIView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var isFavorited: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewIsFavoritedBtn.layer.cornerRadius = viewIsFavoritedBtn.frame.width / 2
        
        imageMovie.layer.cornerRadius = 5
        imageMovie.layer.masksToBounds = true
    }
    
    func config(movies: [Movie], at index: Int) {
        let movie = movies[index]
        if let image = movie.poster_path {
            let url = URL(string: Network.shared.imageUrl + image)
            imageMovie.kf.setImage(with: url)
            isFavorited.image = UIImage(named: "notFavorited")
        }
    }

}
