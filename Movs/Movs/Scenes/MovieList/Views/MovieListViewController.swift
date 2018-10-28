//
//  MovieListViewController.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

protocol MovieListDisplayLogic: class {
    func displayMovies(viewModel: MovieListModel.ViewModel.Success)
    func displayError(viewModel: MovieListModel.ViewModel.Error)
}

class MovieListViewController: UIViewController, MovieListDisplayLogic {
    
    var interactor: MovieListBussinessLogic!
    var router: MovieListRoutingLogic!
    
    var page = 1
    var data: MovieListModel.ViewModel.Success = MovieListModel.ViewModel.Success(movies: [])
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 170, height: 242)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .white
        view.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar(frame: .zero)
        view.barTintColor = UIColor.Movs.yellow
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Movs.yellow.cgColor
        view.placeholder = "Search"
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
    
    override func loadView() {
        setupViewController()
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
    }
    
    private func setupViewController() {
        let view = UIView(frame: .zero)
        self.view = view
        title = "Movies"
        tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: Constants.ImageName.list), tag: 0)
        setupView()
    }
    
    private func fetchMovies() {
        interactor.fetchMovies(request: MovieListModel.Request(page: page))
        page += 1
        
    }
    
    func displayMovies(viewModel: MovieListModel.ViewModel.Success) {
        data = viewModel
        collectionView.reloadData()
    }
    
    func displayError(viewModel: MovieListModel.ViewModel.Error) {
        
    }
    
    func pressedFavorite(sender: UIButton) {
        let position = sender.convert(CGPoint.zero, to: collectionView.coordinateSpace)
        let indexPath = collectionView.indexPathForItem(at: position)
        if let indexPath = indexPath {
            interactor.favoriteMovie(at: indexPath.row)
        }
    }
}

