//
//  MovieListViewController.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit
import GameplayKit

protocol MovieListDisplayLogic: class {
    func displayMovies(viewModel: MovieListModel.ViewModel.Success)
    func displayError(viewModel: MovieListModel.ViewModel.Error)
    func displayNotFind(viewModel: MovieListModel.ViewModel.Error)
}

class MovieListViewController: UIViewController, MovieListDisplayLogic {
    
    var interactor: MovieListBussinessLogic!
    var router: MovieListRoutingLogic!
    
    var page = 1
    var data: MovieListModel.ViewModel.Success = MovieListModel.ViewModel.Success(movies: [])
    var viewError: MovieListErrorView.ViewError?
    var stateMachine: StateMachine!
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 170, height: 242)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .white
        view.keyboardDismissMode = .onDrag
        view.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar(frame: .zero)
        view.barTintColor = UIColor.Movs.yellow
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Movs.yellow.cgColor
        view.placeholder = "Search"
        view.delegate = self
        return view
    }()
    
    lazy var errorView: MovieListErrorView = {
        let view = MovieListErrorView()
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchMovies()
    }
    
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
    
    private func setupViewController() {
        let view = UIView(frame: .zero)
        self.view = view
        title = "Movies"
        tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: Constants.ImageName.list), tag: 0)
        setupView()
        stateMachine = StateMachine(states: [MovieListDisplayState(viewController: self), MovieListLoadingState(viewController: self), MovieListErrorState(viewController: self)])
        _ = stateMachine.enter(MovieListDisplayState.self)
    }
    
    private func fetchMovies() {
        _ = stateMachine.enter(MovieListLoadingState.self)
        interactor.fetchMovies(request: MovieListModel.Request.Page(page: page))
    }
    
    func fetchMoreMovies() {
        page += 1
        fetchMovies()
    }
    
    func displayMovies(viewModel: MovieListModel.ViewModel.Success) {
        data = viewModel
        _ = stateMachine.enter(MovieListDisplayState.self)
    }
    
    func displayError(viewModel: MovieListModel.ViewModel.Error) {
        viewError = MovieListErrorView.ViewError(movieTitle: nil, errorType: .error)
        _ = stateMachine.enter(MovieListErrorState.self)
    }
    
    func displayNotFind(viewModel: MovieListModel.ViewModel.Error) {
        viewError = MovieListErrorView.ViewError(movieTitle: nil, errorType: .notFind)
        viewError?.movieTitle = viewModel.error
        _ = stateMachine.enter(MovieListErrorState.self)
    }
    
    func filterMovies(named: String) {
        let request = MovieListModel.Request.Movie(title: named)
        _ = stateMachine.enter(MovieListLoadingState.self)
        interactor.filterMovies(request: request)
    }
    
    func pressedFavorite(sender: UIButton) {
        let position = sender.convert(CGPoint.zero, to: collectionView.coordinateSpace)
        let indexPath = collectionView.indexPathForItem(at: position)
        if let indexPath = indexPath {
            interactor.favoriteMovie(at: indexPath.row)
        }
    }
}

