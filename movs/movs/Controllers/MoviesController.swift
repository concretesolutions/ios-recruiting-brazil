//
//  MoviesController.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class MoviesController: UIViewController {
    // MARK: - Attributes
    lazy var screen = MoviesScreen(controller: self)
    let dataService = DataService.shared
    var movies: [Movie] = []
    var nextPage: Int = 1
    var searchFilteredBy = ""
    
    // MARK: - Collection state
    var collectionState: CollectionState = .loading {
        didSet {
            switch self.collectionState {
            case .loading:
                if self.nextPage == 1 {
                    self.dataService.loadMovies(of: self.nextPage) { (state) in
                        self.collectionState = state
                    }
                } else {
                    self.collectionState = .normal
                }
            case .loadSuccess:
                self.nextPage += 1
                self.movies = self.dataService.movies
            case .loadError:
                self.screen.showErrorView()
            case .normal:
                self.screen.presentEmptySearch(false)
                self.movies = self.dataService.movies
            case .filtered:
                self.movies = self.dataService.movies.filter({ (movie) -> Bool in
                    return movie.title.lowercased().contains(self.searchFilteredBy.lowercased())
                })
                
                if self.movies.count == 0 {
                    self.screen.presentEmptySearch(true)
                } else {
                    self.screen.presentEmptySearch(false)
                }
            }
            
            // Reload collection view if not loading or the first time
            if self.collectionState != .loading || self.nextPage != 1 {
                DispatchQueue.main.async {
                    self.screen.moviesCollectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - View controller life cycle
    override func loadView() {
        super.loadView()
        self.title = "Movies"
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionState = .loading
        super.viewWillAppear(animated)
    }
    
    // MARK: - Collection view reloading from refresh controll
    @objc func reloadCollectionView(_ sender: UIRefreshControl) {
        self.collectionState = .loading
        sender.endRefreshing()
    }
}

// MARK: - Collection view data source
extension MoviesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch self.collectionState {
        case .loading:
            return 1
        case .loadError:
            return 0
        case .loadSuccess, .normal, .filtered:
            return self.movies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.collectionState == .loading {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell
        let movie = self.movies[indexPath.row]
        cell?.setup(with: movie)
        return cell!
    }
}

// MARK: - Collection view delegate
extension MoviesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        let movieDetailControler = MovieDetailController(movie: movie)
        self.navigationController?.pushViewController(movieDetailControler,
                                                      animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == self.movies.count - 1 && self.collectionState != .filtered {
            self.dataService.loadMovies(of: self.nextPage) { (state) in
                self.collectionState = state
            }
        }
    }
}

// MARK: - Search results updating
extension MoviesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.searchFilteredBy = searchController.searchBar.text ?? ""
        // Set state according to search existence
        if self.searchFilteredBy.isEmpty {
            self.collectionState = .normal
        } else {
            self.collectionState = .filtered
        }
    }
}
