//
//  TrendingMoviesViewController.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class TrendingMoviesViewController: UIViewController, MoviesVC {
    
    var dataSource = MovieCollectionDataSource()
    var delegate = MovieCollectionDelegate()
    var movieViewModel = TrendingMoviesViewModel()
    let moviesView = TrendingMoviesView()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    weak var favoriteMovieDelegate: FavoriteMovieDelegate?
    override func loadView() {
        view = moviesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        setupSearchController()
        setup(with: dataSource)
        moviesView.setupCollectionView(delegate: delegate, dataSource: dataSource)
        movieViewModel.fetchTrendingMovies()
        movieViewModel.fetchGenres { genres in
            let localGenre: [GenreLocal] = CoreDataManager.fetch()
            print("LOCAL: \(localGenre.count)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesView.reloadCollectionData()
    }
    
    func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        definesPresentationContext = true
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
        let movieDetailVC = MovieDetailViewController(with: movie)
        print()
        let favoriteVC = (tabBarController as! TabBarController).favoriteMoviesVC
        movieDetailVC.favoriteMovieDelegate = favoriteVC
        navigationController?.pushViewController(movieDetailVC, animated: true)
        print("MOVIE INDEX: \(movie.title ?? "none")")
    }
    
    func didFavoriteMovie(at index: Int, turnFavorite: Bool) {
        let movie = dataSource.data[index]
        movie.isFavorite = turnFavorite
        self.favoriteMovieDelegate?.didToggle(movie)
    }
}

// MARK: - SearchResultsUpdating
extension TrendingMoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            movieViewModel.searchMovies(query: text)
        }
    }
}
