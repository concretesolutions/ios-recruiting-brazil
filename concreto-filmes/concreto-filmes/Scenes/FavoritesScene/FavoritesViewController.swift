//
//  FavoritesViewController.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 31/10/18.
//  Copyright (c) 2018 Leonel Menezes. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FavoritesDisplayLogic: class {
    func display(movies: [Favorites.ViewModel.movie])
}

class FavoritesViewController: UITableViewController, FavoritesDisplayLogic {
    var interactor: FavoritesBusinessLogic?
    var router: (NSObjectProtocol & FavoritesRoutingLogic & FavoritesDataPassing)?
    var displayedMovies: [Favorites.ViewModel.movie] = []
    var cellId = "favoritesCustomCell"
    var isFiltering = false
    
    private let emptyListLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Desculpe, não pudemos achar nada nos seus favoritos..."
        label.numberOfLines = 3
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    
    private let rightBarButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = #imageLiteral(resourceName: "FilterIcon")
        btn.tintColor = .black
        return btn
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.layer.borderColor = UIColor.gray.cgColor
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        return searchBar
    }()
    
    // MARK: Object lifecycle
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
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
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.presentMovies(shouldFiter: self.isFiltering)
    }
    
    func display(movies: [Favorites.ViewModel.movie]) {
        self.displayedMovies = movies
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
    }
}

extension FavoritesViewController: CodeView {
    func buildViewHierarchy() {
        self.navigationItem.rightBarButtonItem = self.rightBarButton
        self.navigationItem.titleView = self.searchBar
    }
    
    func setupConstraints() {
        
    }
    
    func setupAdditionalConfiguration() {
        self.tableView.backgroundColor = .black
        self.tableView.separatorStyle = .none
        self.tableView.register(FavoritesCustomCell.self, forCellReuseIdentifier: self.cellId)
        self.navigationController?.navigationBar.barTintColor = AppColors.mainYellow.color
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
}
