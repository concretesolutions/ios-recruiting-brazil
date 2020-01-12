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

    var collectionViewDataSource: CollectionViewDataSource<MovieCollectionViewCell>!

    init(viewModel: MoviesViewModel = MoviesViewModel()) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        self.view = moviesView
        self.title = "Movies"

        moviesView.collectionView.register(MovieCollectionViewCell.self)
        moviesView.collectionView.delegate = self

        viewModel.setLoadingLayout = moviesView.setLoadingLayout
        viewModel.setEmptyLayout = moviesView.setEmptyLayout
        viewModel.setShowLayout = moviesView.setShowLayout
        viewModel.updateData = updateData
        viewModel.showError = showError
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadMovies()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateData(viewModels: [MovieCellViewModel]) {
        self.collectionViewDataSource = CollectionViewDataSource<MovieCollectionViewCell>(viewModels: viewModel.model)
        moviesView.collectionView.dataSource = self.collectionViewDataSource
    }

    func showError(error: Error) {
        self.showError(message: error.localizedDescription) { [weak self] in
            self?.viewModel.loadMovies()
        }
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectMovie(index: indexPath.item)
    }
}
