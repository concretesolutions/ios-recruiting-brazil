//
//  MoviewsCollectionViewCell.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

final class MoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    static func fileName() -> String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: fileName(), bundle: nil)
    }
    
    static func identifier() -> String {
        return "movieCollection"
    }
    
    weak var delegate: FavoriteMovieDelegate?
    var item: Movie?
    
    func setup(with item: Movie) {
        if DataManager.shared.checkData(movieId: item.id) {
            self.btnFavorite.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
        } else {
            self.btnFavorite.setImage(#imageLiteral(resourceName: "favorite_gray_icon"), for: .normal)
        }
        self.item = item
        if item.posterPath != "" {
            movieImage.downloaded(from: "https://image.tmdb.org/t/p/w300\(item.posterPath)", contentMode: .scaleAspectFill)
        }
        movieName.text = item.title
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        guard let delegate = delegate, let item = item else { return }
        delegate.favoriteMovie(movie: item)
    }
}
