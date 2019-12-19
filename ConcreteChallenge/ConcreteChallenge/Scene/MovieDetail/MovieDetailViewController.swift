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
        self.title = "Movies"

        viewModel.setLoadingLayout = movieDetailView.setLoadingLayout
        viewModel.setShowLayout = movieDetailView.setShowLayout
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
