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
    @IBOutlet weak var favoriteButton: UIButton!
    
    static func fileName() -> String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: fileName(), bundle: nil)
    }
    
    static func identifier() -> String {
        return "movieCollection"
    }
    
    func setup(with item: Movie) {
        movieImage.downloaded(from: "https://image.tmdb.org/t/p/w300\(item.posterPath)", contentMode: .scaleAspectFill)
        movieName.text = item.title
    }
}
