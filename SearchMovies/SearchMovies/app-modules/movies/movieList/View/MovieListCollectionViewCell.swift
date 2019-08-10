//
//  MovieListCollectionViewCell.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
import UIKit

protocol MovieListCollectionViewCellDelegate:class {
    func didFavoriteButtonTap(isFavorite:Bool)
}

class MovieListCollectionViewCell: UICollectionViewCell {
    //MARK: Properties
    weak var delegate:MovieListCollectionViewCellDelegate?
    private var isFavoriteMovie:Bool!
    //MARK: Outlets
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //MARK: Functions
    func fill(title:String, urlPhotoImage:String, isFavoriteMovie:Bool) {
        DispatchQueue.main.async {
            self.titleLabel.text = title
            self.photoImage.downloaded(from: urlPhotoImage)
            self.isFavoriteMovie = isFavoriteMovie
            let imageNameFavorite:String = isFavoriteMovie ? "favorite_full_icon" : "favorite_gray_icon"
            let imageFavorite:UIImage = UIImage(named: imageNameFavorite)!
            self.favoriteButton.imageView?.image = imageFavorite
        }
    }
    
    func setFavoriteButton(isFavoriteMovie:Bool) {
        DispatchQueue.main.async {
            let imageNameFavorite:String = isFavoriteMovie ? "favorite_full_icon" : "favorite_gray_icon"
            let imageFavorite:UIImage = UIImage(named: imageNameFavorite)!
            self.favoriteButton.imageView?.image = imageFavorite
        }
    }
    
    //MARK: Action
    @IBAction func didFavoriteButtonTap(_ sender: UIButton) {
        guard let delegateButton = self.delegate else {return}
        delegateButton.didFavoriteButtonTap(isFavorite: self.isFavoriteMovie)
    }
    
}
