//
//  MoviesListCollectionViewCell.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 02/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonFavorite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func instanceOfNib() -> UINib {
        return UINib(nibName: MoviesListCollectionViewCell.reusableIdentifier, bundle: Bundle.main)
    }
    
    func setData(for movie: Movie) {
        guard let image = URL(string: APIData.imagePath + movie.image!) else { return }
        
        imageViewPoster.sd_setImage(with: image, completed: nil)
        
        if let title = movie.title {
            labelTitle.text = title
        }
    }
}
