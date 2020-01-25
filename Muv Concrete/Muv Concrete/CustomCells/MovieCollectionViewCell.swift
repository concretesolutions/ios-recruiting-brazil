//
//  CollectionViewCell.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 15/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    let identiifier = "MovieCollectionViewCell"
    
    var movie: Movie? {
        didSet {
            configure()
        }
    }
    
    private func configure() {
        guard let movie = movie else { return }
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            
            if let imagePath = movie.posterPath {
                self.imageView.downloaded(from: imagePath, contentMode: .scaleToFill)
            }
        }
    }
    
    @IBAction func favorite(_ sender: Any) {
        let defaults = UserDefaults.standard
        let arrayFavoritesIds = defaults.array(forKey: "favoritesIds")
        var arraySave: [Int32] = []
        guard let id = movie?.id else { return }
        
        if favoriteButton.isSelected {
            favoriteButton.isSelected = false
                if arrayFavoritesIds != nil {
                    arraySave = arrayFavoritesIds as! [Int32]
                    arraySave = arraySave.filter( {$0 != id })
                }
        } else {
            favoriteButton.isSelected = true
                if arrayFavoritesIds != nil {
                    arraySave = arrayFavoritesIds as! [Int32]
                }
                arraySave.append(id)
            
        }

        defaults.set(arraySave, forKey: "favoritesIds")
        print(defaults.array(forKey: "favoritesIds"))
    }
    
}
