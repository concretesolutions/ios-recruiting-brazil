//
//  FavoriteMovieCell.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 09/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FavoriteMovieCell: UITableViewCell {

    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    
    var model: MovieDetailModel? {
        didSet{
            setupViews()
        }
    }
    
    func setupViews() {
        guard let model = self.model else { return }
        if let posterData = model.posterData {
            posterImage.image = UIImage(data: posterData)
        }
        titleLabel.text = model.title
        dateLabel.text = model.releaseYear
        descriptionLabel.text = model.description
    }
}
