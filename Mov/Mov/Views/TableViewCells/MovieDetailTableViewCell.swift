//
//  MovieDetailTableViewCell.swift
//  Mov
//
//  Created by Allan on 13/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

final class MovieDetailTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak private var lblTitle: UILabel!
    @IBOutlet weak private var btnFavorite: UIButton!
    @IBOutlet weak private var imgViewCover: UIImageView!
    @IBOutlet weak private var lblText: UILabel!
    
    //MARK: - Actions
    
    @IBAction private func DidTappedFavoriteButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.isSelected ? delegate?.didAddedToFavorite(movie: movie) : delegate?.didRemovedFromFavorite(movie: movie)
    }
    
    //MARK: - Variables
    
    var delegate: FavoriteMovieDelegate?
    private var movie: Movie!
    
    //MARK: - Functions
    
    func setup(with item: TableViewItem, movie: Movie, withDelegate delegate: FavoriteMovieDelegate?){
        self.delegate = delegate
        self.movie = movie
        
        switch item.type {
        case .cover:
            if let urlString = item.imageURL, let url = URL(string: urlString){
                imgViewCover.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: [], completed: nil)
            }
        case .simple:
            lblTitle.text = item.text
            
            btnFavorite.isHidden = true
            if let isFavorite = item.isFavorite{
                btnFavorite.isSelected = isFavorite
                btnFavorite.isHidden = false
            }
            
        case .text:
            lblText.text = item.text
        }
    }

}
