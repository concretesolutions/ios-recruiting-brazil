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
    var loadingIndicator: UIActivityIndicatorView!
    let searchController = UISearchController(searchResultsController: nil)
    var searchTimer: Timer?
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
        moviesView.collectionView.prefetchDataSource = dataSource
        startFetch()
        moviesView.errorRequestView.tryAgainAction = { [weak self] in
            self?.startFetch()
        }
    }
    
    func startFetch() {
        setLoadingIndicator()
        movieViewModel.fetchTrendingMovies()
        movieViewModel.fetchGenres()
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
    
    func setLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView()
        view.addSubview(loadingIndicator!)
        loadingIndicator!.anchor
            .centerX(view.centerXAnchor)
            .centerY(view.centerYAnchor)
            .width(constant: 20)
            .height(constant: 20)
        loadingIndicator!.startAnimating()
    }
    
    func removeLoadingIndicator() {
        loadingIndicator?.stopAnimating()
        loadingIndicator?.removeFromSuperview()
        loadingIndicator = nil
    }
}

// MARK: - DataFetchDelegate
extension TrendingMoviesViewController {
    func didUpdateData() {
        
        DispatchQueue.main.async {
            self.moviesView.reloadCollectionData()
            self.removeLoadingIndicator()
        }
    }
    
    func didChange(page: Int) {
        movieViewModel.fetchTrendingMovies(page: page)
    }

    func didFailFetchData(with error: Error) {
        guard let networkError = error as? NetworkError else { return}
        DispatchQueue.main.async {
            self.removeLoadingIndicator()
            
            var imageName: String
            var message: String
            var isGenericError: Bool
            
            switch networkError {
            case .emptyResult:
                imageName = "search_icon"
                message = "Não houve resultados para a busca."
                isGenericError = false
            default:
                imageName = "error_icon"
                message = "Um erro ocorreu."
                isGenericError = true

            }
            
            self.moviesView.addErrorRequestView(imageName: imageName, message: message, isGenericError: isGenericError)
        }
    }
        
}

// MARK: - MoviesDelegate
extension TrendingMoviesViewController {
    func didSelectMovie(at index: Int) {
        let movie = dataSource.data[index]
        let movieDetailVC = MovieDetailViewController(with: movie)
        let favoriteVC = (tabBarController as! TabBarController).favoriteMoviesVC
        movieDetailVC.favoriteMovieDelegate = favoriteVC
        navigationController?.pushViewController(movieDetailVC, animated: true)
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
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
            
            if let text = searchController.searchBar.text, !text.isEmpty {
                self?.moviesView.removeErrorRequestView()
                self?.movieViewModel.searchMovies(query: text)
            } else {
                self?.startFetch()
            }
        })
        
        
    }
}
