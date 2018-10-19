//
//  MovieCollectionViewCell.swift
//  Mov
//
//  Created by Allan on 09/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit
import SDWebImage

protocol FavoriteMovieDelegate {
    func didAddedToFavorite(movie: Movie)
    func didRemovedFromFavorite(movie: Movie)
}

final class MovieCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak private var imgViewCell: UIImageView!
    @IBOutlet weak private var lblTitle: UILabel!
    @IBOutlet weak private var btnFavorite: UIButton!
    
    //MARK: - Actions
    @IBAction private func DidTappedFavoriteButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.isSelected ? delegate?.didAddedToFavorite(movie: movie) : delegate?.didRemovedFromFavorite(movie: movie)
    }
    
    
    //MARK: - Variables
    var delegate: FavoriteMovieDelegate?
    private var movie: Movie!
    
    //MARK: - Functions
    func setup(with movie: Movie, withDelegate delegate: FavoriteMovieDelegate?){
        self.delegate = delegate
        self.movie = movie
        lblTitle.text = movie.title
        
        if let urlString = movie.imageURL, let url = URL(string: urlString){
            imgViewCell.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: [], completed: nil)
        }
        
        btnFavorite.isSelected = movie.isMyFavorite
    }
    

}
