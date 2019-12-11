//
//  TrendingMoviesViewController.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class TrendingMoviesViewController: UIViewController, MoviesVC {
    let dataSource = MovieCollectionDataSource()
    var delegate = MovieCollectionDelegate()
    var movieViewModel = TrendingMoviesViewModel()
    let moviesView = TrendingMoviesView()
    
    override func loadView() {
        view = moviesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        setupDelegateDataSource()
        moviesView.setupCollectionView(delegate: delegate, dataSource: dataSource)
        movieViewModel.fetchTrendingMovies()
    }
        
    // MARK: - ViewWillTransition
    /// Correct collectionView layout on view transition
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        moviesView.invalidateCollectionLayout()
    }
}

// MARK: - DataFetchDelegate
extension TrendingMoviesViewController {
    func didUpdateData() {
        DispatchQueue.main.async {
            print(self.dataSource.data)
            self.moviesView.reloadCollectionData()
        }
    }
    func didFailFetchData(with error: Error) {
        print("Error AQUI AQUI: \(error)")
    }
}

// MARK: - MoviesDelegate
extension TrendingMoviesViewController {
    func didSelectMovie(at index: Int) {
        let movie = dataSource.data[index]
        navigationController?.pushViewController(MovieDetailViewController(), animated: true)
        print("MOVIE INDEX: \(movie.title ?? "none")")
    }
}
