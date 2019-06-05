//
//  FavoritesTableViewCell.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 04/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import UIKit
import SDWebImage

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewFavoritePoster: UIImageView!
    @IBOutlet weak var labelFavoriteTitle: UILabel!
    @IBOutlet weak var labelFavoriteReleaseYear: UILabel!
    @IBOutlet weak var labelFavoriteDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(for movie: Movie) {
        guard let image = URL(string: APIData.imagePath + movie.image!) else { return }
        
        imageViewFavoritePoster.sd_setImage(with: image, completed: nil)
        
        if let title = movie.title {
            labelFavoriteTitle.text = title
        }
        
        if let year = movie.releaseDate {
            let index = year.index(year.startIndex, offsetBy: 4)
            
            labelFavoriteReleaseYear.text = String(year.prefix(upTo: index))
        }
        
        if let description = movie.description {
            labelFavoriteDescription.text = description
        }
    }
}
