//
//  MoviesCollectionCell.swift
//  Movs
//
//  Created by Rafael Douglas on 18/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import AlamofireImage

protocol MoviesCollectionCellDelegate{
    func didTapFavoritedBtn(movie: Movie)
}

class MoviesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGrade: UILabel!
    @IBOutlet weak var movieFavoriteIcon: UIButton!
    
    
    var movieItem: Movie!
    var delegate: MoviesCollectionCellDelegate?
    
    func prepare() {
        if let title = self.movieItem.title {
            self.movieTitle.text = title
        }
        if let path = self.movieItem.poster_path {
            let url = URL(string: API_MOVIEDB_URL_IMAGE_BASE + path)!
            self.movieImage.af_setImage(withURL: url)
        }
        
        //Get Icon depends if movie was added or not
        let movieWasAdded = CoreDataDelegate.movieWasAdded(movie: self.movieItem!)
        if(movieWasAdded == true){
            movieFavoriteIcon.setImage(UIImage(named: "favorite_icon"), for: UIControl.State.normal)
        }else{
            movieFavoriteIcon.setImage(UIImage(named: "favorite_icon_empty"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func makeFavorite(_ sender: Any) {
        movieFavoriteIcon.setImage(UIImage(named: "favorite_icon"), for: UIControl.State.normal)
        delegate?.didTapFavoritedBtn(movie: self.movieItem)
    }
    
}
