//
//  MovieListViewController.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit
import GameplayKit

class MovieListViewController: UIViewController, MovieListDisplayLogic {
    
    var interactor: MovieListBussinessLogic!
    var router: MovieListRoutingLogic!
    
    /// Page of movies to request.
    var page = 1
    /// Data to display.
    var data: MovieList.ViewModel.Success = MovieList.ViewModel.Success(movies: [])
    /// Error of view.
    var viewError: MovieListErrorView.ViewError?
    var stateMachine: StateMachine!
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 170, height: 242)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return view
    }()
    
    lazy var searchBar: SearchBar = {
        let view = SearchBar(frame: .zero)
        view.textChanged = filterMovies
        return view
    }()
    
    lazy var errorView: MovieListErrorView = {
        let view = MovieListErrorView()
        return view
    }()
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - ViewController Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
    // MARK: - Setup Methods
    
    /**
     Setup the entire scene.
     */
    private func setup() {
        let viewController = self
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter()
        let router = MovieListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        setupViewController()
    }
    
    /**
     Setup view controller data.
     */
    private func setupViewController() {
        let view = UIView(frame: .zero)
        self.view = view
        title = "Movies"
        tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: Constants.ImageName.list), tag: 0)
        setupView()
        stateMachine = StateMachine(states: [MovieListDisplayState(viewController: self), MovieListLoadingState(viewController: self), MovieListErrorState(viewController: self)])
        _ = stateMachine.enter(MovieListDisplayState.self)
    }
    
    // MARK: - Fetch Methods
    
    /**
     Fetch movies to display.
     */
    private func fetchMovies() {
        _ = stateMachine.enter(MovieListLoadingState.self)
        interactor.fetchMovies(request: MovieList.Request.Page(page: page))
    }
    
    /**
     Fetch more movies to display.
     */
    func fetchMoreMovies() {
        page += 1
        fetchMovies()
    }
    
    // MARK: - Display Logic
    
    func displayMovies(viewModel: MovieList.ViewModel.Success) {
        data = viewModel
        _ = stateMachine.enter(MovieListDisplayState.self)
    }
    
    func displayError(viewModel: MovieList.ViewModel.Error) {
        viewError = MovieListErrorView.ViewError(movieTitle: nil, errorType: .error)
        _ = stateMachine.enter(MovieListErrorState.self)
    }
    
    func displayNotFind(viewModel: MovieList.ViewModel.Error) {
        viewError = MovieListErrorView.ViewError(movieTitle: nil, errorType: .notFind)
        viewError?.movieTitle = viewModel.error
        _ = stateMachine.enter(MovieListErrorState.self)
    }
    
    // MARK: - Filter Methods
    
    /**
     Filter movies by name.
     
     - parameters:
         - named: Name of the movie to filter.
     */
    func filterMovies(named: String) {
        _ = stateMachine.enter(MovieListLoadingState.self)
        let request = MovieList.Request.Movie(title: named)
        interactor.filterMovies(request: request)
    }
    
    // MARK: - Favorite Methods
    
    /**
     When favorite button is pressed.
     
     - parameters:
         - sender: Button that was pressed.
     */
    func pressedFavorite(sender: UIButton) {
        let position = sender.convert(CGPoint.zero, to: collectionView.coordinateSpace)
        let indexPath = collectionView.indexPathForItem(at: position)
        if let indexPath = indexPath {
            interactor.favoriteMovie(at: indexPath.row)
        }
    }
    
}

