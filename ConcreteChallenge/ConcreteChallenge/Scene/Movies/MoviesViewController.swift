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

        viewModel.loadMovies()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateData(viewModels: [MovieCellViewModel]) {
        self.collectionViewDataSource = CollectionViewDataSource<MovieCollectionViewCell>(viewModels: viewModel.model)
        moviesView.collectionView.dataSource = self.collectionViewDataSource
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectMovie(index: indexPath.item)
    }
}
