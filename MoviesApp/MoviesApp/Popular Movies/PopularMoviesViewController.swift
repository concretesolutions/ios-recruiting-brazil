//
//  PopularMoviesViewController.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 10/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    let screen = PopularMoviesScreen(frame: UIScreen.main.bounds)
    
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
        
        self.fetchMovies()
        self.fetchGenres()
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
        service.fetchPopularMovies { [weak self] result in
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
        self.screen.setupCollectionView(with: movies, selectionDelegate: self)
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
