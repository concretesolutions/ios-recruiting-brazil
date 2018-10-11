//
//  MovieCollectionViewCell.swift
//  DataMovie
//
//  Created by Andre Souza on 14/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgPoster: UIImageView!
    
    var item: MovieListItem? {
        didSet {
            imgPoster.image = item?.poster
        }
    }

}
