//
//  MovieCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 26/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        backgroundColor = Colors.primary
        movieLabel.textColor = Colors.accent
    }
}
