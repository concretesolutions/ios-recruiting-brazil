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

    var collectionViewDataSource = CollectionViewDataSource<MovieCollectionViewCell>(viewModels: [])

    init(viewModel: MoviesViewModel = MoviesViewModel()) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        view = moviesView
        title = "Movies"

        moviesView.collectionView.register(MovieCollectionViewCell.self)
        moviesView.collectionView.dataSource = collectionViewDataSource
        moviesView.collectionView.prefetchDataSource = self
        moviesView.collectionView.delegate = self

        viewModel.setLoadingLayout = moviesView.setLoadingLayout
        viewModel.setEmptyLayout = moviesView.setEmptyLayout
        viewModel.setShowLayout = moviesView.setShowLayout
        viewModel.updateData = updateData
        viewModel.showError = showError

        viewModel.loadMovies()
    }

    override func viewWillAppear(_ animated: Bool) {
        updateFavoriteStateForVisibleCells()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func calculateIndexPathsToReload(from newViewModels: [MovieCellViewModel]) -> [IndexPath] {
        let startIndex = collectionViewDataSource.viewModels.count
        let endIndex = startIndex + newViewModels.count
        return (startIndex..<endIndex).map { IndexPath(item: $0, section: 0) }
    }

    func updateData(newViewModels: [MovieCellViewModel]) {
        let indexPaths = calculateIndexPathsToReload(from: newViewModels)
        collectionViewDataSource.viewModels.append(contentsOf: newViewModels)
        moviesView.collectionView.insertItems(at: indexPaths)
    }

    func showError(error: Error) {
        showError(message: error.localizedDescription) { [weak self] in
            self?.viewModel.loadMovies()
        }
    }

    func updateFavoriteStateForVisibleCells() {
        let indexes = moviesView.collectionView.indexPathsForVisibleItems.map({ $0.item })
        for index in indexes {
            collectionViewDataSource.viewModels[index].loadFavoriteState()
        }
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectMovie(index: indexPath.item)
    }
}

extension MoviesViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // Load more items when reach de last item
        if indexPaths.last?.item == collectionViewDataSource.viewModels.count - 1 {
            viewModel.loadMovies()
        }
    }
}
