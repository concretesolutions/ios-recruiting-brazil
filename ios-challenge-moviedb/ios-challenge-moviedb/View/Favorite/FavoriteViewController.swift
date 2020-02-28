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
    
    var presenter: MoviePresenter?
    
    private var estimatedCellWidth: CGFloat = Constants.MovieCollectionView.estimatedCellWidth
    private var cellMargin: CGFloat = Constants.MovieCollectionView.cellMargin
    
    var fetchingMoreMovies: Bool = false
    
    private var searchedMovies: [Movie]?
        
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
        let errorView = ErrorView(errorImageName: Constants.ErrorValues.popularImageName, errorText: Constants.ErrorValues.popularMoviesText)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()
    
    init(presenter: MoviePresenter) {
        super.init(nibName: nil, bundle: nil)
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
         }
    }
    
    override func viewDidLoad() {
        setupUI()
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
    }
    
    @objc func handleFavorite(_ sender: UIButton) {
        var cellMovie: Movie?
        guard let movies = presenter?.movies else { return }
        for movie in movies {
            if movie.id == sender.tag {
                cellMovie = movie
            }
        }
        guard let movie = cellMovie else { return }
        presenter?.handleMovieFavorite(movie: movie)
        presenter?.changeButtonImage(button: sender, movie: movie)
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

extension FavoriteViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedMovies?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MovieCollectionView.cellId, for: indexPath) as? MovieCollectionViewCell else {
            fatalError("Wrong Cell ID")
        }

        if let movies = self.searchedMovies {
            cell.movieImage.kf.indicatorType = .activity
            let movie = movies[indexPath.item]
            cell.movieTitle.text = movie.title
            presenter?.changeButtonImage(button: cell.favoriteButton, movie: movie)
            cell.favoriteButton.tag = movie.id
            cell.favoriteButton.addTarget(self, action: #selector(handleFavorite(_:)), for: .touchUpInside)
            let moviePosterImageURL = presenter?.getMovieImageURL(width: 200, path: movie.posterPath ?? "")
            cell.movieImage.kf.setImage(with: moviePosterImageURL) { result in
                switch result {
                case .failure(let error): print("Não foi possivel carregar a imagem:", error.localizedDescription)
                    // Tratar o error
                cell.movieImage.image = UIImage(named: Constants.ErrorValues.imageLoadingError)
                default: break
                }
            }
        }
        return cell
    }
}

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showMovieDetails(movie: indexPath.item)
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
        }
        reloadData()
    }
}



