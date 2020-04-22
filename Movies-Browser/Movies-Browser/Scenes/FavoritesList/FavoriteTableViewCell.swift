//
//  FavoriteTableViewCell.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 20/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteTableViewCell: UITableViewCell {
    // MARKL - IBOutlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
}

// MARK: - Setup -
extension FavoriteTableViewCell {
    func setup(posterPath: String, title: String, year: String, overview: String){
        posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        posterImageView
            .sd_setImage(with: URL(string: AppConstants.API.imageBaseUrl + posterPath), placeholderImage: UIImage(named: "placeholder"))
        titleLabel.text = title
        releaseDateLabel.text = year
        overviewLabel.text = overview
    }
}
