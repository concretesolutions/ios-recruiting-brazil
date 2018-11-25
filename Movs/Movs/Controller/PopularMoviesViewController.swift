//
//  PopularMoviesViewController.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit
import SnapKit

//TODO: - Verificar conexão

class PopularMoviesViewController: UIViewController {

    //MARK: - Properties
    // interface
    let collectionView = PopularMoviesCollectionView()
    var collectionViewDelegate: PopularMoviesCollectionViewDelegate?
    var collectionViewDatasource: PopularMoviesCollectionViewDataSource?
    lazy var exceptionView = ExceptionFeedbackView(delegate: self)
    // Search Controller
    var searchText: String = ""
    let searchController = UISearchController(searchResultsController: nil)
    // Configurations
    var currentPage: Int = 1
    var isFetching: Bool = false
    // Data
    let db = RealmManager.shared
    var genresList = [Genre]()
    var popularMovies = [Movie]()
    var favoriteMovies = [Movie]()
    // Services
    let tmdbService = TMDBService()
    
    //MARK: - Interface
    lazy var activityIndicator:UIActivityIndicatorView = {
        var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = Design.colors.dark
        activityIndicator.contentMode = .scaleAspectFit
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    //MARK: - UI States Control
    
    // Loading
    fileprivate enum LoadingState {
        case loading
        case ready
    }

    fileprivate var loadingState: LoadingState = .loading {
        didSet {
            updateLoading(state: loadingState)
        }
    }
    
    // Presentation
    fileprivate enum PresentationState {
        case emptyResult
        case loadingContent
        case showingContent
        case error
    }
    
    fileprivate var presentationState: PresentationState = .loadingContent {
        didSet {
            DispatchQueue.main.async {
                self.updatePresentation(state: self.presentationState)
            }
        }
    }
    
    //MARK: - TMDB Service Query Control
    fileprivate var tmdbQueryType: TMDBQueryType = .popular {
        didSet {
            if oldValue != tmdbQueryType {
                currentPage = 1
                popularMovies.removeAll()
                loadingState = .loading
                presentationState = .loadingContent
            }
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initalSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCollectionView(with: self.popularMovies)
    }
    
    //MARK: - UI State handlers
    fileprivate func updateLoading(state: LoadingState) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
        case .ready:
            activityIndicator.stopAnimating()
        }
    }
    
    fileprivate func updatePresentation(state: PresentationState) {
        switch state {
        case .emptyResult:
            collectionView.isHidden = true
            activityIndicator.isHidden = true
            exceptionView.isHidden = false
            exceptionView.exeptionType = .emptyResult(searchText)
        case .loadingContent:
            collectionView.isHidden = true
            activityIndicator.isHidden = false
            exceptionView.isHidden = true
        case .showingContent:
            collectionView.isHidden = false
            activityIndicator.isHidden = true
            exceptionView.isHidden = true
        case .error:
            collectionView.isHidden = true
            activityIndicator.isHidden = true
            exceptionView.isHidden = false
            exceptionView.exeptionType = .genericError
        }
    }
    
    //MARK: - Setup
    func initalSetup() {
        setupSearchBar()
        getAllGenres()
    }
    
    func setupCollectionView(with movies: [Movie]) {
        let flaggedMovies = flagFavoriteMovies(movies)
        collectionViewDatasource = PopularMoviesCollectionViewDataSource(movies: flaggedMovies, collectionView: collectionView, delegate: self)
        collectionView.dataSource = collectionViewDatasource
        
        collectionViewDelegate = PopularMoviesCollectionViewDelegate(movies: flaggedMovies, delegate: self)
        collectionView.delegate = collectionViewDelegate
        
        collectionView.reloadData()
    }
    
    // Setup Datasource Realm
    func flagFavoriteMovies(_ movies: [Movie]) -> [Movie] {
        favoriteMovies.removeAll()
        db.getAll(MovieRlm.self).forEach({ favoriteMovies.append(Movie($0)) })
        var flaggedMovies = movies
        for i in 0..<flaggedMovies.count {
            if let _ = favoriteMovies.first(where: {$0.id == flaggedMovies[i].id}) {
                flaggedMovies[i].favorite()
            }
        }
        return flaggedMovies
    }
    
    //MARK: - TMDB Service
    func getAllGenres() {
        loadingState = .loading
        tmdbService.getGenres { (result) in
            switch result {
            case .success(let genres):
                self.genresList = genres
                self.getPopularMovies(page: 1)
            case .error(let anError):
                print("Error: \(anError)")
                self.presentationState = .error
            }
        }
    }
    
    func getPopularMovies(page: Int) {
        isFetching = true
        tmdbQueryType = .popular
        tmdbService.getPopularMovies(page: page) { (result) in
            switch result {
            case .success(let movies):
                self.popularMovies.append(contentsOf: movies)
                self.setupCollectionView(with: self.popularMovies)
                self.loadingState = .ready
                self.presentationState = .showingContent
            case .error(let anError):
                print("Error: \(anError)")
                self.presentationState = .error
            }
            self.isFetching = false
        }
    }
    
    func searchPopularMovies(containing text: String, page: Int) {
        isFetching = true
        tmdbQueryType = .search
        tmdbService.searchMoviesContaining(text, page: page) { (result) in
            switch result {
            case .success(let movies):
                if movies.isEmpty {
                    self.isFetching = false
                    self.presentationState = .emptyResult
                    return
                }
                self.popularMovies.append(contentsOf: movies)
                self.setupCollectionView(with: self.popularMovies)
                self.loadingState = .ready
                self.presentationState = .showingContent
            case .error(let anError):
                print("Error: \(anError)")
                self.presentationState = .error
            }
            self.isFetching = false
        }

    }
    
}

//MARK: - MovieSelectionDelegate
extension PopularMoviesViewController: MovieSelectionDelegate {
    func didSelect(movie: Movie) {
        var aMovie = movie
        aMovie.genres = movie.genres.map { (movieGenre) -> Genre in
            return genresList.first(where: { $0.id == movieGenre.id }) ?? Genre(id: movieGenre.id)
        }
        let movieVC = MovieDetailTableViewController(movie: aMovie)
        movieVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(movieVC, animated: true)
    }
}

//MARK: - CollectionViewPagingDelegate
extension PopularMoviesViewController: CollectionViewPagingDelegate {
    func shouldFetchNextPage() {
        if !isFetching {
            currentPage += 1
            switch tmdbQueryType {
            case .popular:
                if tmdbService.isPageAvailable(page: currentPage, for: .popular) {
                    getPopularMovies(page: currentPage)
                }
            case .search:
                if tmdbService.isPageAvailable(page: currentPage, for: .search) {
                    searchPopularMovies(containing: searchText, page: currentPage)
                }
            }
        }
    }
}

//MARK: - UISearchBarDelegate
extension PopularMoviesViewController: UISearchBarDelegate {
    
    func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchController.searchBar.text ?? ""
        if !searchText.isEmpty {
            searchPopularMovies(containing: searchText, page: 1)
        }
        searchController.dismiss(animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchText = ""
        getPopularMovies(page: 1)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchText = searchController.searchBar.text ?? ""
        if searchText.isEmpty{
            getPopularMovies(page: 1)
        }
    }
    
}

//MARK: - ExceptionFeedbackDelegate
extension PopularMoviesViewController: ExceptionFeedbackDelegate {
    // can expand to other types of exceptions
    func handleException(ofType type: ExceptionType) {
        switch type {
        case .emptyResult:
            getPopularMovies(page: 1)
        case .genericError:
            currentPage = 1
            popularMovies.removeAll()
            presentationState = .loadingContent
            initalSetup()
        }
    }
}

//MARK: - CodeView
extension PopularMoviesViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(exceptionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        exceptionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        presentationState = .loadingContent
        view.backgroundColor = Design.colors.white
        navigationController?.navigationBar.tintColor = Design.colors.dark
        navigationController?.navigationBar.barTintColor = Design.colors.mainYellow
    }
}
