//
//  MovieDetailViewController.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let movieDetailView = MovieDetailView()

    var viewModel: MovieDetailViewModel!

    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        self.view = movieDetailView
        self.title = ""

        self.view.layer.addSublayer(Gradient.main(UIScreen.main.bounds.width, 200, color: .white))

        viewModel.setLoadingLayout = movieDetailView.setLoadingLayout
        viewModel.setShowLayout = setShowLayout
        viewModel.updateImage = updateImage

        viewModel.loadImage()
        viewModel.loadGenres()
    }

    func setShowLayout() {
        movieDetailView.titleLabel.text = viewModel?.title
        movieDetailView.overviewLabel.text = viewModel?.overview
        movieDetailView.yearLabel.text = viewModel?.releaseYear
        movieDetailView.genresLabel.text = viewModel?.genres
        updateImage()

        movieDetailView.loadingView.isHidden = true
        movieDetailView.loadingView.stop()

        movieDetailView.contentView.isHidden = false
    }

    func updateImage() {
        movieDetailView.coverImageView.image = viewModel?.image
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
