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
    
    internal let searchController = UISearchController(searchResultsController: nil)
    internal let screen = FavoriteMoviesViewScreen()
    internal let errorScreen = ErrorViewScreen()
    internal let viewModel: FavoriteMoviesControllerViewModel
    internal var displayedError: ApplicationError = .none
    
    // MARK: - Publishers and Subscribers
    
    private var subscribers: [AnyCancellable?] = []
    
    // MARK: - Initializers and Deinitializers
    
    init(viewModel: FavoriteMoviesControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.bind(to: self.viewModel)
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
        
        self.screen.favoriteMoviesTableView.delegate = self
        self.screen.favoriteMoviesTableView.dataSource = self
        self.configureSearchBar()
    }
    
    // MARK: - Binding
    
    func bind(to viewModel: FavoriteMoviesControllerViewModel) {
        self.subscribers.append(viewModel.$numberOfFavoriteMovies
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in
                if let index = self.viewModel.deletedIndex {
                    self.screen.favoriteMoviesTableView.deleteRows(at: [index], with: .fade)
                    self.viewModel.deletedIndex = nil
                } else {
                    self.screen.favoriteMoviesTableView.reloadData()
                }
            })
        )
        
        self.subscribers.append(viewModel.$searchStatus
            .receive(on: RunLoop.main)
            .sink(receiveValue: { status in
                if status == .noResults {
                    self.showSearchError()
                } else if self.displayedError == .searchError {
                    self.displayedError = .none
                    self.view = self.screen
                }
            })
        )
    }
}
