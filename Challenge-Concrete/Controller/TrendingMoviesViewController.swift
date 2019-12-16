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
    let loadingIndicator = UIActivityIndicatorView()
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
        view.addSubview(loadingIndicator)
        loadingIndicator.anchor.attatch(to: view)
        loadingIndicator.startAnimating()
    }
}

// MARK: - DataFetchDelegate
extension TrendingMoviesViewController {
    func didUpdateData() {
        DispatchQueue.main.async {
            self.moviesView.reloadCollectionData()
            self.loadingIndicator.stopAnimating()
        }
    }

    func didFailFetchData(with error: Error) {
        guard let networkError = error as? NetworkError else { return}
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            
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
        if let text = searchController.searchBar.text, !text.isEmpty {
            moviesView.removeErrorRequestView()
            self.loadingIndicator.startAnimating()
            movieViewModel.searchMovies(query: text)
        } else {
            startFetch()
        }
    }
}
