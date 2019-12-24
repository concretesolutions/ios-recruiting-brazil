//
//  PopularMoviesViewController.swift
//  Movs
//
//  Created by Lucca Ferreira on 01/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit
import Combine

class PopularMoviesViewController: UIViewController {

    // Properties
    private let viewModel = PopularMoviesViewModel()
    private lazy var screen: PopularMoviesView = {
        return PopularMoviesView(forController: self)
    }()
    private let searchController: SearchController = SearchController(withPlaceholder: "Search")
    private var state: ExceptionView.State = .none

    // Cancellables
    private var stateCancellable: AnyCancellable?
    private var movieCountCancellable: AnyCancellable?
    private var networkCancellable: AnyCancellable?

    override func loadView() {
        self.view = self.screen
    }

    required init() {
        super.init(nibName: nil, bundle: nil)

        // Sets SearchController for this ViewController
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true

        self.viewModel.getMovies()
        self.setCombine()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setCombine() {
        self.movieCountCancellable = self.viewModel.$movieCount
            .receive(on: RunLoop.main)
            .sink { _ in
                self.screen.reloadCollectionView()
            }
        self.stateCancellable = self.viewModel.$state
            .receive(on: RunLoop.main)
            .assign(to: \.state, on: self.screen)
        self.networkCancellable = self.viewModel.$withoutNetwork
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (value) in
                if value == true && self.state != .withoutNetwork {
                    let alert = UIAlertController(title: "Connection problem",
                                                  message: "We encountered problems with your connection.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        self.viewModel.setSearchCombine(forSearchController: self.searchController)
        self.viewModel.setNetworkCombine()
    }
    
}

// CollectionView DataSource
extension PopularMoviesViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.movieCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCollectionViewCell",
                                                            for: indexPath) as? PopularMoviesCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(withViewModel: self.viewModel.viewModelForCell(at: indexPath))
        return cell
    }

}

// CollectionView Delegate
extension PopularMoviesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = MovieDetailsViewController(withMovieViewModel: self.viewModel.viewModelDetailsForCell(at: indexPath))
        self.navigationController!.pushViewController(controller, animated: true)
    }

}

// CollectionView DataSourcePrefetching
extension PopularMoviesViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let indexPath = indexPaths.first else { return }
        if indexPath.row >= self.viewModel.movieCount - 2 {
            self.viewModel.getMovies()
        }
    }

}
