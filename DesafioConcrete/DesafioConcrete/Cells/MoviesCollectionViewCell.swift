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
    @IBOutlet weak var imgFavorite: UIImageView!
    
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
        self.item = item
        if DataManager.shared.checkData(movieId: item.id) {
            self.imgFavorite.image = FavoriteImages.favorited.getImage()
        } else {
            self.imgFavorite.image = FavoriteImages.unfavorited.getImage()
        }
        if item.posterPath != "" {
            movieImage.downloaded(from: item.posterPath, contentMode: .scaleAspectFill)
        }
        movieName.text = item.title
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        guard let delegate = delegate, let item = item else { return }
        delegate.favoriteMovie(movie: item)
    }
}
