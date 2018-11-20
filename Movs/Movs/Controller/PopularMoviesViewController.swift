//
//  PopularMoviesViewController.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit
import SnapKit

class PopularMoviesViewController: UIViewController {
    
    //MARK: - Properties
    let db = RealmManager.shared
    let tmdbService = TMDBService()
    let collectionView = PopularMoviesCollectionView()
    var collectionViewDelegate: PopularMoviesCollectionViewDelegate?
    var collectionViewDatasource: PopularMoviesCollectionViewDataSource?
    
    var currentPage:Int = 1
    var isFetching:Bool = false
    var genresList = [Genre]()
    var popularMovies = [Movie]()
    var favouriteMovies = [Movie]()

    //MARK: - Interface
    lazy var activityIndicator:UIActivityIndicatorView = {
        var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = Design.colors.secondaryYellow
        activityIndicator.contentMode = .scaleAspectFit
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    //MARK: - UI States Control
    fileprivate enum LoadingState {
        case loading
        case ready
    }
    
    fileprivate enum PresentationState {
        case initial
        case showContent
        case error
    }
    
    fileprivate var loadingState: LoadingState = .loading {
        didSet {
            updateLoading(state: loadingState)
        }
    }
    
    fileprivate var presentationState: PresentationState = .initial {
        didSet {
            DispatchQueue.main.async {
                self.updatePresentation(state: self.presentationState)
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
    
    //MARK: UI States handlers
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
        case .initial:
            collectionView.isHidden = true
            activityIndicator.isHidden = false
        case .showContent:
            collectionView.isHidden = false
            activityIndicator.isHidden = true
        case .error:
            collectionView.isHidden = true
            activityIndicator.isHidden = true
        }
    }
    
    //MARK: - Setup
    func initalSetup() {
        getAllGenres()
    }
    
    func setupCollectionView(with movies: [Movie]) {
        let flaggedMovies = flagFavouriteMovies(movies)
        collectionViewDatasource = PopularMoviesCollectionViewDataSource(movies: flaggedMovies, collectionView: collectionView, delegate: self)
        collectionView.dataSource = collectionViewDatasource
        
        collectionViewDelegate = PopularMoviesCollectionViewDelegate(movies: flaggedMovies, delegate: self)
        collectionView.delegate = collectionViewDelegate
        
        collectionView.reloadData()
    }
    
    // Setup Datasource Realm
    func flagFavouriteMovies(_ movies: [Movie]) -> [Movie] {
        favouriteMovies.removeAll()
        db.getAll(MovieRlm.self).forEach({ favouriteMovies.append(Movie($0)) })
        var flaggedMovies = movies
        for i in 0..<flaggedMovies.count {
            if let _ = favouriteMovies.first(where: {$0.id == flaggedMovies[i].id}) {
                flaggedMovies[i].favourite()
            }
        }
        return flaggedMovies
    }
    
    //MARK: TMDB Service
    func getPopularMovies(page: Int) {
//        loadingState = .loading
//        presentationState = .initial
        isFetching = true
        tmdbService.getPopularMovies(page: page) { (result) in
            switch result {
            case .success(let movies):
                self.popularMovies.append(contentsOf: movies)
                self.setupCollectionView(with: self.popularMovies)
                self.loadingState = .ready
                self.presentationState = .showContent
            case .error(let anError):
                print("Error: \(anError)")
                self.presentationState = .error
            }
            self.isFetching = false
        }
    }
    
    func getAllGenres(){
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
    
}

extension PopularMoviesViewController: MovieSelectionDelegate {
    func didSelect(movie: Movie) {
        var aMovie = movie
        aMovie.genres = movie.genres.map { (movieGenre) -> Genre in
            return genresList.first(where: { $0.id == movieGenre.id }) ?? Genre(id: movieGenre.id)
        }
        let movieVC = MovieTableViewController(movie: aMovie)
        navigationController?.pushViewController(movieVC, animated: true)
    }
}

extension PopularMoviesViewController: CollectionViewPagingDelegate {
    func shouldFetchNextPage() {
        if !isFetching {
            currentPage += 1
            getPopularMovies(page: currentPage)
        }
    }
}


extension PopularMoviesViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
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
    }
    
    func setupAdditionalConfiguration() {
        presentationState = .initial
        view.backgroundColor = Design.colors.white
        navigationController?.navigationBar.tintColor = Design.colors.dark
        navigationController?.navigationBar.barTintColor = Design.colors.mainYellow
    }
}
