//
//  FavoriteViewController.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 28/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteViewController: UIViewController {
    
    var presenter: FavoriteMoviePresenter?
    
    private var collectionViewDataSource: FavoritesCollectionViewDataSource?
    
    private var estimatedCellWidth: CGFloat = Constants.MovieCollectionView.estimatedCellWidth
    private var cellMargin: CGFloat = Constants.MovieCollectionView.cellMargin
    
    var fetchingMoreMovies: Bool = false
    
    var searchedMovies: [Movie]?
        
    var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: Constants.MovieCollectionView.cellMargin,
                                           left: 7,
                                           bottom: Constants.MovieCollectionView.cellMargin,
                                           right: 7)
        layout.minimumLineSpacing = Constants.MovieCollectionView.cellMargin
        layout.minimumInteritemSpacing = Constants.MovieCollectionView.cellMargin
        layout.estimatedItemSize = CGSize(width: Constants.MovieCollectionView.estimatedCellWidth,
                                          height: Constants.MovieCollectionView.estimatedCellHeight + 30)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constants.MovieCollectionView.cellId)
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    var errorView: ErrorView = {
        let errorView = ErrorView(errorImageName: Constants.ErrorValues.searchImageError, errorText: Constants.ErrorValues.searchMovieText)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()
    
    init(presenter: FavoriteMoviePresenter) {
        super.init(nibName: nil, bundle: nil)
        self.collectionViewDataSource = FavoritesCollectionViewDataSource(viewController: self)
        self.presenter = presenter
        self.navigationItem.title = "Favorites"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - Loads Movies Data
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.presenter?.loadCollectionView(page: 1)
            self.searchedMovies = self.presenter?.movies
            if self.searchedMovies?.count == 0 {
                self.showError(imageName: self.errorView.errorImageName, text: self.errorView.errorText)
            } else {
                self.removeError()
            }
         }
    }
    
    override func viewDidLoad() {
        setupUI()
        movieCollectionView.dataSource = collectionViewDataSource
        movieCollectionView.delegate = self
    }
    
    func setupUI() {
        self.view.addSubview(movieCollectionView)
        setupConstaints()
        setupSearchBar()
    }
    
    func setupSearchBar() {
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        let searchBar = navigationItem.searchController?.searchBar
        searchBar?.searchBarStyle = UISearchBar.Style.prominent
        searchBar?.placeholder = "Search for Movies..."
        searchBar?.sizeToFit()
        searchBar?.isTranslucent = false
        searchBar?.tintColor = .white
        searchBar?.barTintColor = .white
        searchBar?.delegate = self
    }
    
    func setupConstaints() {
        // MARK: - Collection View Constraints
        movieCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        movieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        movieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        movieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupErrorContraints() {
        errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies = searchedMovies else { return }
        presenter?.showMovieDetails(movie: indexPath.item, from: movies)
    }
}

extension FavoriteViewController: MovieViewDelegate {
    
    func showError(imageName: String, text: String) {
        self.view.addSubview(errorView)
        errorView.errorText = text
        errorView.errorImageName = imageName
        errorView.setupUI()
        errorView.setupConstraints()
        setupErrorContraints()
    }
    
    func removeError() {
        errorView.removeFromSuperview()
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.movieCollectionView.reloadData()
            self.fetchingMoreMovies = false
        }
    }
}

extension FavoriteViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            checkIfNeedsToRemoveError()
            searchedMovies = presenter?.movies
            reloadData()
            return
        }
        searchedMovies = presenter?.movies.filter({ (movie) -> Bool in
            guard let text = searchBar.text else { return false }
            return movie.title.contains(text)
        })
        
        if searchedMovies?.count == 0 {
            searchedMovies = nil
            showError(imageName: errorView.errorImageName, text: errorView.errorText)
        } else {
            checkIfNeedsToRemoveError()
        }
        reloadData()
    }
    
    func checkIfNeedsToRemoveError() {
        if errorView.superview != nil {
            removeError()
        }
    }
}

extension FavoriteViewController : FavoriteMoviesProtocol {
    func handleMovieFavorite(movie: Movie) {
        presenter?.handleMovieFavoriteTap(movie: movie)
    }
    
    func changeButtonImage(button: UIButton, movie: Movie) {
        let isFavorite = presenter?.handleChangeButtonImage(movie: movie)
        if isFavorite == true {
            button.setImage(UIImage(named: Constants.FavoriteButton.imageNamedFull), for: .normal)
        } else {
            button.setImage(UIImage(named: Constants.FavoriteButton.imageNamedNormal), for: .normal)
        }
    }
}
