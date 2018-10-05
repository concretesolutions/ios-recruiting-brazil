//
//  MovieCell.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    static let cellSize = CGSize(width: 150, height: 250)
    
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieReleaseDate: UILabel!
    
    var model: MovieModel? {
        didSet {
            setupView()
        }
    }

    private func setupView() {
        setMovieTitle()
        setMovieReleaseDate()
    }
    
    private func setMovieTitle() {
        movieTitleLabel.text = model?.title
    }
    
    private func setMovieReleaseDate() {
        if let releaseDate = model?.releaseDate {
            movieReleaseDate.text = "Lançado em: \(releaseDate)"
            movieReleaseDate.isHidden = false
        } else {
            movieReleaseDate.isHidden = true
        }
    }
}
