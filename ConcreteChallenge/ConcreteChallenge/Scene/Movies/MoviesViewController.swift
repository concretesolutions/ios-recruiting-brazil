//
//  MoviesViewController.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 18/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    let moviesView = MoviesView()

    var viewModel: MoviesViewModel!

    init(viewModel: MoviesViewModel = MoviesViewModel()) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        self.view = moviesView
        self.title = "Movies"

        viewModel.setLoadingLayout = moviesView.setLoadingLayout
        viewModel.setEmptyLayout = moviesView.setEmptyLayout
        viewModel.setListLayout = moviesView.setListLayout
        viewModel.setGridLayout = moviesView.setGridLayout
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
