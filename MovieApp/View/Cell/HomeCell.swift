//
//  HomeCell.swift
//  MovieApp
//
//  Created by Mac Pro on 27/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import SDWebImage


protocol HomeCellDelegate {
    func onClickFavoriteCell(index: Int, isFavorite: Bool)
}

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var topoIv: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var cellDelegate: HomeCellDelegate?
    var index: IndexPath?
    var isFavorite: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(movie: Movie, isFavorite: Bool = false){
        self.isFavorite = isFavorite
        if isFavorite {
            favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        }else {
            favoriteButton.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
        }
        
        topoIv.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"), completed: nil)
        titleLb.text = movie.title
        
    }

    @IBAction func bottonFavoriteTapped(_ sender: Any) {
        if isFavorite! {
            favoriteButton.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        }
        isFavorite = !isFavorite!
        cellDelegate?.onClickFavoriteCell(index: (index?.item)!, isFavorite: !isFavorite!)
    }


}
