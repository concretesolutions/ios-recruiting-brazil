//
//  ViewController.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit
import Alamofire
import Nuke

class MoviesViewController: UIViewController {
    
    var movies = [Movie]()
    var favMoviesIds = [Int]()
    var filteredMovies = [Movie]()
    
    private var currentPage = 1
    
    let client = MovieAPIClient()
    let preheater = ImagePreheater()
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    // MARK: iOS Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadPreviouslyFavoritedMovies()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPreviouslyFavoritedMovies()
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.prefetchDataSource = self
        
        
        // UIRefreshControl setup
        moviesCollectionView.refreshControl = UIRefreshControl()
        moviesCollectionView.refreshControl?.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
        moviesCollectionView.refreshControl?.beginRefreshing()
        
        loadMovies()
        
        setupSearchController()
    }
    
    private func fetchNextPage() {
        currentPage += 1
        loadMovies()
    }
    
    @objc private func refreshMovies() {
        currentPage = 1
        loadMovies(refresh: true)
    }
    
    private func loadMovies(refresh: Bool = false) {
        client.fetchPopularMovies(page: currentPage) { response in
            
            switch response {
            case .success(let pagedResponse):
                self.moviesCollectionView.isHidden = false
                self.messageLabel.isHidden = true
                DispatchQueue.main.async {
                    if refresh {
                        self.movies = pagedResponse.results
                    } else {
                        pagedResponse.results.forEach { movie in
                            if !self.movies.contains(movie) {
                                self.movies.append(movie)
                            }
                        }
                    }
                    self.moviesCollectionView.refreshControl?.endRefreshing()
                    self.moviesCollectionView.reloadData()
                    
                }
            case .failure( _):
                self.moviesCollectionView.isHidden = true
                self.messageLabel.isHidden = false
            }
        }
    }
    
    private func loadPreviouslyFavoritedMovies() {
        if let array = UserDefaults.standard.array(forKey: "favMovies") as? [Int] {
            favMoviesIds = array
            
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
            }
        }
    }
    
    private func isFavorite(_ index: Int) -> Bool {
        let movie = isFiltering() ? filteredMovies[index].id : movies[index].id
        return !favMoviesIds.contains(movie)
    }
    
    // SearchController Helper Methods
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filter(with searchText: String) {
        filteredMovies = movies.filter { movie in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        if filteredMovies.count == 0 && !searchBarIsEmpty() {
            messageLabel.text = "Sua busca por \(searchText) não produziu resultados. :("
            messageLabel.isHidden = false
            moviesCollectionView.isHidden = true
        } else {
            moviesCollectionView.isHidden = false
            messageLabel.isHidden = true
            moviesCollectionView.reloadData()
        }
        
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search popular movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: UICollectionView Delegate and DataSource Methods


extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering() ? filteredMovies.count : movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionCell
        
        let movie = isFiltering() ? filteredMovies[indexPath.row] : movies[indexPath.row]
        
        cell.movie = movie
        cell.favoriteImageView.isHidden = isFavorite(indexPath.row)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        showMovie(at: indexPath)
    }
    
    func showMovie(at indexPath: IndexPath) {
        guard let movieVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movieDetails") as? MovieDetailViewController else { fatalError("could not instantiate movies view controller") }
        guard let navigator = navigationController else {
            fatalError("navigation controller is nil")
        }
        
        movieVC.movie = isFiltering() ? filteredMovies[indexPath.row] : movies[indexPath.row]
        navigator.pushViewController(movieVC, animated: true)
    }
    
    // MARK: Paging logic
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard isPageAtTheEnd(indexPath) else { return }
        fetchNextPage()
    }
    
    private func isPageAtTheEnd(_ indexPath: IndexPath) -> Bool {
        return indexPath.row == self.movies.count - 1
    }
    
}

// MARK: Prefetching Methods

extension MoviesViewController: UICollectionViewDataSourcePrefetching {
    
    func imagesURLFor(indexPaths: [IndexPath]) -> [URL] {
        return indexPaths.compactMap { indexPath in
            guard indexPath.row < self.movies.count else { return nil }
            return MovieAPIClient.imageURL(with: self.movies[indexPath.row].posterPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let urlsToPreheat: [URL] = imagesURLFor(indexPaths: indexPaths)
        
        // Nuke's preheater manages all the image load requests. If a duplicate request is made, Nuke will not allow it and instead add another observer for the existing request.
        preheater.startPreheating(with: urlsToPreheat)
        
        // In case indexPaths are on the next page
        let needsFetch = indexPaths.contains { $0.row >= self.movies.count }
        if needsFetch {
            fetchNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        let urlsToStopPreheating: [URL] = imagesURLFor(indexPaths: indexPaths)
        preheater.stopPreheating(with: urlsToStopPreheating)
    }
    
}

// MARK: UISearchResultsUpdating Delegate

extension MoviesViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        filter(with: searchController.searchBar.text!)
    }
}


