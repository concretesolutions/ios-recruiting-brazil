//
//  PopularMoviesViewController.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 10/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    let screen = PopularMoviesScreen(frame: .zero)
    
    var service = MoviesServiceImplementation()
    var movies:[Movie] = []
    var genres:[Genre] = []
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "Movies"
        let tabBarItem = UITabBarItem(title: "Popular Movies", image: UIImage(named: "list_icon"), selectedImage: UIImage(named: "list_icon"))
        self.tabBarItem = tabBarItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        self.fetchMovies()
        self.fetchGenres()
        self.setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.screen.collectionView.reloadData()
        super.viewWillAppear(animated)
    }
    
    override func loadView() {
        self.view = screen
    }
    
}

extension PopularMoviesViewController {
    func fetchMovies(query: String? = nil) {
//        loadingState = .loading
        service.fetchPopularMovies(query: query) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.handleFetch(of: movies)
            case .error:
                print("handle error in fetching movies")
                
            }
        }
    }
    
    func handleFetch(of movies: [Movie]) {
        self.movies = movies
        self.screen.collectionView.setupCollectionView(with: movies, selectionDelegate: self)
        self.navigationItem.searchController?.searchBar.resignFirstResponder()
    }
    
}

extension PopularMoviesViewController{
    func fetchGenres(){
        service.fetchGenre { [weak self] result in
            switch result{
            case .success(let genres):
                self?.handleFetch(of: genres)
            case .error:
                print("handle error in fetching genres")
            }
        }
    }
    
    func handleFetch(of genres:[Genre]){
        self.genres = genres
    }
}

extension PopularMoviesViewController: MovieSelectionDelegate{
    func didSelect(movie: Movie) {
        let detailController = MovieDetailViewController(movie: movie, genres: self.genres)
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

extension PopularMoviesViewController: UISearchBarDelegate{
    
    func setupSearchBar(){
//        self.screen.setupSearchBarDelegate(delegate: self)
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.screen.setup(searchController: searchController)
//        self.navigationItem.titleView = self.screen.searchBar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            if !text.isEmpty{
                fetchMovies(query: text)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchMovies()
    }
    
}
