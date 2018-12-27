//
//  DetailsScreen.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 26/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import UIKit
import Kingfisher

final class DetailsScreen: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!

    // MARK: - Properties
    private var movie: Movie!
}

// MARK: - Public
extension DetailsScreen {
    func setup(movie: Movie) {
        self.movie = movie
    }
}

// MARK: - Lifecycle
extension DetailsScreen {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let imageUrl = URL(string: Constants.Integration.imageurl + movie.imagePath)
        movieImageView.kf.setImage(with: imageUrl)

        titleLabel.text = movie.name
        yearLabel.text = String(movie.releaseDate.prefix(4))
        genreLabel.text = "test"
        descriptionTextView.text = movie.description
    }
}
