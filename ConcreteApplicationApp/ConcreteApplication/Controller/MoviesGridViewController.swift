//
//  MoviesGridViewController.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import SnapKit

class MoviesGridViewController: UIViewController {
    
    //FIXME:- Create status of empty search
    
    //CollectionView
    let collectionView = MoviesGridCollectionView()
    var collectionViewDataSource: MoviesGridCollectionDataSource?
    var collectionViewDelegate: MoviesGridCollectionDelegate?
    //Auxiliar Views
    lazy var activityIndicator = ActivityIndicator(frame: .zero)
    var errorView = ErrorView(frame: .zero)
    lazy var emptySearchView = EmptySearchView(frame: .zero)
    //SearchController
    let searchController = UISearchController(searchResultsController: nil)
    //TMDB API
    let tmdb = TMDBManager()
    //Properties
    var movies:[Movie] = []
    var genres:[Genre] = []
    var currentPage = 0
    
    
    fileprivate enum PresentationState{
        case loadingContent
        case displayingContent
        case error
        case emptySearch
    }
    
    
    fileprivate var presentationState: PresentationState = .loadingContent{
        didSet{
            DispatchQueue.main.async {
                self.refreshUI(for: self.presentationState)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSearchBar()
        presentationState = .loadingContent
        self.fetchGenres()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        presentationState = .loadingContent
        self.getMoviesFromRealm()
    }
    
    func fetchGenres(){
        tmdb.getGenres { (result) in
            self.presentationState = .loadingContent
            switch result{
            case .success(let genres):
                self.genres = genres
                self.fetchMovies(page: 1)
                self.currentPage = 1
            case .error:
                self.presentationState = .error
            }
        }
    }
    
    func fetchMovies(page: Int){
        tmdb.getPopularMovies(page: page) { (result) in
            switch result{
            case .success(let movies):
                self.movies.append(contentsOf: movies)
                self.getMoviesFromRealm()
            case .error(let error):
                self.presentationState = .error
                print(error.localizedDescription)
            }
        }
    }
    
    func getMoviesFromRealm(){
        self.clearFavoriteMovies()
        let favoritedMovies = RealmManager.shared.getAll(objectsOf: MovieRealm.self)
        for favoritedMovie in favoritedMovies{
            for (index,movie) in self.movies.enumerated(){
                if favoritedMovie.id == movie.id{
                    self.movies[index].isFavorite = true
                }
            }
        }
        self.handleFetchOf(movies: self.movies)
    }
    
    func clearFavoriteMovies(){
        for (index,_) in self.movies.enumerated(){
            self.movies[index].isFavorite = false
        }
    }
    
    
    func handleFetchOf(movies:[Movie]){
        self.setupCollectionView(with: movies)
        self.presentationState = .displayingContent
    }
    
    
    func setupCollectionView(with movies: [Movie]){
        collectionViewDataSource = MoviesGridCollectionDataSource(movies: movies, collectionView: self.collectionView, pagingDelegate: self)
        self.collectionView.dataSource = collectionViewDataSource
        collectionViewDelegate = MoviesGridCollectionDelegate(movies: movies, delegate: self)
        self.collectionView.delegate = collectionViewDelegate
        self.collectionView.reloadData()
    }
    
}

//MARK:- CodeView protocol
extension MoviesGridViewController: CodeView{
    
    func buildViewHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(errorView)
        view.addSubview(emptySearchView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        errorView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        emptySearchView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

//MARK:- Handling with UI changings

extension MoviesGridViewController{
    
    fileprivate func refreshUI(for presentationState: PresentationState){
        switch presentationState{
        case .loadingContent:
            collectionView.isHidden = true
            activityIndicator.isHidden = false
            errorView.isHidden = true
            emptySearchView.isHidden = true
        case .displayingContent:
            collectionView.isHidden = false
            activityIndicator.isHidden = true
            errorView.isHidden = true
            emptySearchView.isHidden = true
        case .error:
            collectionView.isHidden = true
            activityIndicator.isHidden = true
            errorView.isHidden = false
            emptySearchView.isHidden = true
        case .emptySearch:
            collectionView.isHidden = true
            activityIndicator.isHidden = true
            errorView.isHidden = true
            emptySearchView.isHidden = false
        }
    }
}

//MARK:- delegates
extension MoviesGridViewController: MoviesSelectionDelegate{
    func didSelectMovie(movie: Movie) {
        var selectedMovie = movie
        var movieGenres:[Genre] = []
        for genre in movie.genres{
            movieGenres.append(contentsOf: self.genres.filter{$0.id == genre.id})
        }
        
        selectedMovie.genres = movieGenres
        let movieDetailController = MovieDetailTableViewController(movie: selectedMovie, style: .grouped)
        movieDetailController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(movieDetailController, animated: true)
    }
}

extension MoviesGridViewController: MoviesGridPagingDelegate{
    
    func shouldFetch(page: Int) {
        if page == self.currentPage + 1{
            self.currentPage += 1
            self.fetchMovies(page: self.currentPage)
        }
    }
    
}

extension MoviesGridViewController: UISearchBarDelegate{
    
    func setupSearchBar(){
        self.searchController.searchBar.delegate = self
        navigationItem.searchController = self.searchController
        definesPresentationContext = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty ?? true{
            handleFetchOf(movies: self.movies)
        }else{
        let filteredMovies = self.movies.filter({$0.title.range(of: searchBar.text ?? "", options: .caseInsensitive) != nil})
            if filteredMovies.count == 0{
                self.presentationState = .emptySearch
            }else{
                handleFetchOf(movies: filteredMovies)
            }
        }
        searchController.dismiss(animated: true, completion: nil)
    }

}
