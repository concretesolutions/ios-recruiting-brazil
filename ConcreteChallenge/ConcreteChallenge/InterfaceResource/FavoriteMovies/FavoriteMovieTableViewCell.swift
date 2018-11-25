//
//  FavoriteMovieTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 16/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Functions
    func setupCell(movie: Movie) {
        
        // Image
        if let posterPath = movie.posterPath {
            ImageDataManager.getImageFrom(imagePath: posterPath) { (image) in
                DispatchQueue.main.async {
                    self.posterImage.image = image
                    movie.image = image
                }
            }
        } else {
            self.posterImage.image = UIImage(named: "image_unavailable")
            movie.image = self.posterImage.image
        }
        
        // Title
        self.nameLabel.text = movie.title
        
        // Release Year
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.year], from: movie.releaseDate)
        if let year = components.year {
            self.releaseDateLabel.text = String(describing: year)
        } else {
            self.releaseDateLabel.text = "Unavailable"
        }
        
        // Overview
        self.overviewTextView.text = movie.overview
        self.overviewTextView.textContainer.lineBreakMode = .byTruncatingTail
    }
}
