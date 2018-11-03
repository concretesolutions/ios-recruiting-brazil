//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

protocol FavoritesDisplayLogic: class {
    func displayFavorites(viewModel: Favorites.ViewModel)
}

class FavoritesViewController: UIViewController, FavoritesDisplayLogic {
    
    var interactor: FavoritesBussinessLogic!
    var router: FavoritesRoutingLogic!
    
    var movies: [Favorites.FavoritesMovie] = []
    var isApplyingFilters = false
    var dateFilter: Filters.Option.Selected?
    var genreFilter: Filters.Option.Selected?
    
    lazy var searchBar: SearchBar = {
        let view = SearchBar(frame: .zero)
        view.textChanged = filterMovies
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.register(FavoritesTableViewCell.self,
                      forCellReuseIdentifier: "Cell")
        return view
    }()
    
    lazy var removeFilterButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Remove Filter", for: .normal)
        view.setTitleColor(UIColor.Movs.yellow, for: .normal)
        view.backgroundColor = UIColor.Movs.darkGray
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        view.addTarget(self, action: #selector(removeFilters), for: .touchUpInside)
        return view
    }()
    
    override init(nibName nibNameOrNil: String?,
                  bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setupViewController() {
        let rightBarImage = UIImage(named: Constants.ImageName.filter)
        let tabBarImage = UIImage(named: Constants.ImageName.favoriteEmpty)
        let rightBarButtonItem = UIBarButtonItem(image: rightBarImage, style: .plain,
                                                 target: self, action: #selector(showFilters))
        view.backgroundColor = .white
        title = "Favorites"
        tabBarItem = UITabBarItem(title: "Favorites", image: tabBarImage, tag: 1)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        setupView()
    }
    
    private func setup() {
        let viewController = self
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isApplyingFilters {
            fetchMovies()
        }
    }
    
    func fetchMovies() {
        let request = Favorites.Request()
        interactor.fetchFavoritesMovies(request: request)
    }
    
    func filterMovies(named: String) {
        let request = Favorites.Request.RequestMovie(title: named)
        interactor.filterMovies(request: request)
    }
    
    @objc func showFilters() {
        router.showFilters()
    }
    
    func applyFilters(movies: [Movie]) {
        let request = Favorites.Request.Filtered(movies: movies)
        isApplyingFilters = true
        updateRemoveFilterLayout()
        interactor.prepareFilteredMovies(request: request)
    }
    
    func activeFilters(date: Filters.Option.Selected?,
                       genre: Filters.Option.Selected?) {
        dateFilter = date
        genreFilter = genre
    }
    
    func updateRemoveFilterLayout() {
        let height = isApplyingFilters ? 45 : 0
        removeFilterButton.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
    }
    
    @objc func removeFilters() {
        isApplyingFilters = false
        updateRemoveFilterLayout()
        fetchMovies()
        dateFilter = nil
        genreFilter = nil
    }
    
    func displayFavorites(viewModel: Favorites.ViewModel) {
        movies = viewModel.movies
        tableView.reloadData()
    }
}
