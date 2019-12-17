//
//  FavoriteMoviesViewController.swift
//  Movs
//
//  Created by Gabriel D'Luca on 06/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import Combine

class FavoriteMoviesViewController: UIViewController {

    // MARK: - Properties
    
    internal var deletedRowIndex: IndexPath?
    internal let screen = FavoriteMoviesViewScreen()
    internal let viewModel: FavoriteMoviesControllerViewModel
    internal let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Publishers and Subscribers
    
    private var subscribers: [AnyCancellable?] = []
    
    // MARK: - Initializers and Deinitializers
    
    init(viewModel: FavoriteMoviesControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        for subscriber in subscribers {
            subscriber?.cancel()
        }
    }
    
    // MARK: - ViewController life cycle
    
    override func loadView() {
        super.loadView()
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(to: self.viewModel)
        self.screen.favoriteMoviesTableView.delegate = self
        self.screen.favoriteMoviesTableView.dataSource = self
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search favorites..."
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    // MARK: - Binding
    
    func bind(to viewModel: FavoriteMoviesControllerViewModel) {
        self.subscribers.append(viewModel.$numberOfFavoriteMovies
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in
                if let deletedIndex = self.deletedRowIndex {
                    self.screen.favoriteMoviesTableView.deleteRows(at: [deletedIndex], with: .fade)
                    self.deletedRowIndex = nil
                } else {
                    self.screen.favoriteMoviesTableView.reloadData()
                }
            })
        )
    }
}
