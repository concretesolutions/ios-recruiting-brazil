//
//  MovieCollectionViewCell.swift
//  MovieDBConcrete
//
//  Created by eduardo soares neto on 20/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var isFavorite = false
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    func changeFavorite() {
        self.isFavorite = !self.isFavorite
    }
}
