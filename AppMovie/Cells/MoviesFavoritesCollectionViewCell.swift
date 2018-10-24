//
//  MoviesFavoritesCollectionViewCell.swift
//  AppMovie
//
//  Created by Renan Alves on 23/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class MoviesFavoritesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterPath: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    
    @IBAction func favorite(_ sender: Any) {
        print("apertou")
    }
    
}
