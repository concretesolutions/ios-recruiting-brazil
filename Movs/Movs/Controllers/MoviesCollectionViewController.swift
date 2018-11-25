//
//  MoviesCollectionViewController.swift
//  Movs
//
//  Created by Julio Brazil on 22/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MoviesCell"

class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDataSourcePrefetching, UISearchResultsUpdating, UISearchBarDelegate {
    var moviesTotal: Int =  0
    var movies = [Movie]()
    var isFetching: Bool = false
    
    var searchController: UISearchController!
    
    init() {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let insets = UIApplication.shared.keyWindow?.safeAreaInsets
        let insetsMargin = (insets?.right ?? 0) + (insets?.left ?? 0)
        let spacing = layout.minimumInteritemSpacing
        let sizeWidth = (screenWidth - (spacing + insetsMargin))/2
        layout.itemSize = CGSize(width: sizeWidth, height: sizeWidth * 3/2)
        
        super.init(collectionViewLayout: layout)
        
        self.tabBarController?.hidesBottomBarWhenPushed = true
        
        self.collectionView.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.prefetchDataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Start loading indicator
        let indicator = UIActivityIndicatorView(style: .gray)
        self.collectionView.backgroundView = indicator
        indicator.startAnimating()
        
        // Setup search
        self.searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        // Fetch movies
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    // MARK: - custom methods
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= movies.count
    }
    
    func showErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            self.collectionView.backgroundView = ErrorView(displayingMessage: message)
            print("showed stuff")
        }
    }
    
    func loadData() {
        TMDBManager.shared.fetchPopularMovies() { [weak self](response) in
            guard let self = self else {return}
            self.handleDataFetch(response, isUpdating: false)
        }
    }
    
    func loadData(forSearch query: String) {
        TMDBManager.shared.fetchMoviesSearching(for: query) { [weak self](response) in
            guard let self = self else { return }
            self.handleDataFetch(response, isUpdating: false)
        }
    }
    
    func handleDataFetch(_ response: responseType<TMDBResponse> ,isUpdating: Bool = false) {
        self.isFetching = false
        
        DispatchQueue.main.async {
            self.collectionView.backgroundView = nil
        }
        
        switch response {
        case .result(let moviesResponse):
            self.moviesTotal = moviesResponse.total_results
            
            let results = moviesResponse.results.map { (movie) -> Movie in
                var newMovie = Movie(from: movie)
                newMovie.genre_names = TMDBManager.shared.genreNames(forIds: movie.genre_ids).joined(separator: ", ")
                return newMovie
            }
            if isUpdating {
                self.movies.append(contentsOf: results)
            } else {
                self.movies = results
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            }
        case .error(let description):
            self.showErrorMessage(description ?? "Generic Error")
        case .empty(let query):
            self.showErrorMessage("No result found for \"\(query)\"")
        }
    }
    
    // MARK: UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text != "" {
            self.loadData(forSearch: text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.loadData()
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        // You could also change the position, frame etc of the searchBar
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = MovieDetailsTableViewController(presenting: movies[indexPath.row])
        detailView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
}
