//
//  MoviesViewController.swift
//  Movs
//
//  Created by Lucca Ferreira on 01/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit
import Combine

class MoviesViewController: UIViewController {

    private let viewModel = PopularMoviesViewModel()
    private let screen = PopularMoviesView()

    var cancellables: [AnyCancellable] = []

    override func loadView() {
        self.view = screen
    }

    required init() {
        super.init(nibName: nil, bundle: nil)
        screen.collectionView.dataSource = self
        screen.collectionView.prefetchDataSource = self

        // Sets SearchController for this ViewController
        self.navigationItem.searchController = SearchController(withPlaceholder: "Search", searchResultsUpdater: self)
        self.definesPresentationContext = true

        // MARK: Sets pull to refresh - Under construction
        // let refreshControl = UIRefreshControl()
        // self.screen.collectionView.refreshControl = refreshControl

        self.setCombine()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCombine() {
        let cancellable = viewModel.$count
            .receive(on: RunLoop.main)
            .sink { _ in
                self.screen.collectionView.performBatchUpdates({
                    self.screen.collectionView.reloadSections(IndexSet(integer: 0))
                })

        }
        self.cancellables.append(cancellable)
    }
    
}

extension MoviesViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchTerm = searchController.searchBar.text else { return }
    }

}

extension MoviesViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCollectionViewCell",
                                                            for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(withViewModel: self.viewModel.viewModel(forCellAt: indexPath))
        return cell
    }

}

extension MoviesViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let indexPath = indexPaths.first else { return }
        if indexPath.row >= viewModel.count - 8 {
            self.viewModel.getMovies()
        }
    }

}
