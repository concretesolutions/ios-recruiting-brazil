//
//  CellMovie.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 04/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable

class  CellMovie: UICollectionViewCell, NibReusable {
    
    //Mark: - Properties
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var bkgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    // MARK: - Init
    func setup(movie: Result){
        titleLabel.text = movie.title
        movieImage.kf.indicatorType = .activity
        //let stringImage = movie?.poster_path
        guard let stringImage = movie.poster_path else {return}
        let Image = "\(URL_IMG)\(stringImage)" 
        if let image = URL(string: Image){
            movieImage.kf.indicatorType = .activity
            movieImage.kf.setImage(with: image)
        }
        
        if (movie.isFavorite == true) {
            favoriteImage.image = UIImage(named:"favorite_full_icon")
        } else {
            favoriteImage.image = UIImage(named:"favorite_gray_icon")
        }
        
    }
    
    public func setFavoriteButtonSelection(_ isSelected:Bool) {
        // set button image
        print(isSelected)
        if (isSelected == true) {
            favoriteImage.image = UIImage(named:"favorite_full_icon")
        } else {
            favoriteImage.image = UIImage(named:"favorite_gray_icon")
        }
    }
}
