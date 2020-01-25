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
        let defaults = UserDefaults.standard
        let arrayFavoritesIds = defaults.array(forKey: "favoritesIds")
        guard let movie = movie else { return }
        let id = movie.id
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            
            if arrayFavoritesIds != nil {
                let arrayIds = arrayFavoritesIds as! [Int32]
                if arrayIds.contains(id) {
                    self.favoriteButton.isSelected = true
                }
            }
            
            if let imagePath = movie.posterPath {
                self.imageView.downloaded(from: imagePath, contentMode: .scaleToFill)
            }
        }
    }
    
    @IBAction func favorite(_ sender: Any) {
        let defaults = UserDefaults.standard
        let arrayFavoritesIds = defaults.array(forKey: "favoritesIds")
        var arraySave: [Int32] = []
        guard let movie = movie else { return }
        let id = movie.id
        let coreData = CoreData()
        
        if favoriteButton.isSelected {
            favoriteButton.isSelected = false
            if arrayFavoritesIds != nil {
                arraySave = arrayFavoritesIds as! [Int32]
                arraySave = arraySave.filter( {$0 != id })
                coreData.deleteElementCoreData(id: id)
            }
        } else {
            favoriteButton.isSelected = true
            if arrayFavoritesIds != nil {
                arraySave = arrayFavoritesIds as! [Int32]
            }
            coreData.saveCoreData(movie: movie)
            arraySave.append(id)
            
        }

        defaults.set(arraySave, forKey: "favoritesIds")
    }
    
}
