//
//  MovieTableViewCell.swift
//  Cineasta
//
//  Created by Tomaz Correa on 01/06/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var isFavoriteImageView: UIImageView!
}

// MARK: - AUX METHODS -
extension MovieTableViewCell {
    public func setupCell(viewData: MovieViewData) {
        self.setImage(posterURL: viewData.posterURL, title: viewData.title)
        self.titleLabel.text = viewData.title
        self.releaseDateLabel.text = viewData.releaseDate
        self.overViewLabel.text = viewData.overview
        self.isFavoriteImageView.tintColor = viewData.isFavorite ? Constants.Colors.selectedAsFavorite : Constants.Colors.unselectedAsFavorite
        self.setCardShadow()
    }
    
    public func setCardShadow() {
        self.cardView.layer.masksToBounds = false
        self.cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.cardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        self.cardView.layer.shadowRadius = 4
        self.cardView.layer.shadowOpacity = 1
    }
    
    private func setImage(posterURL: String, title: String) {
        let url = URL(string: posterURL)
        let options: KingfisherOptionsInfo = [.transition(.fade(1)), .cacheOriginalImage]
        self.posterImageView.kf.setImage( with: url, placeholder: UIImage(named: title), options: options)
    }
}
