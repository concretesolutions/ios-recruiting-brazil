//
//  CollectionViewCell.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 15/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
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
}
