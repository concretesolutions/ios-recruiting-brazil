//
//  PopularMoviesViewController.swift
//  Movs
//
//  Created by Gabriel D'Luca on 02/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import Combine

class PopularMoviesViewController: UIViewController {

    // MARK: - Properties
    
    internal let searchController = UISearchController(searchResultsController: nil)
    internal let screen = PopularMoviesViewScreen()
    internal let viewModel: PopularMoviesControllerViewModel
    
    // MARK: - Publishers and Subscribers
    
    internal var subscribers: [AnyCancellable?] = []
    
    // MARK: - Initializers and Deinitializers
    
    init(viewModel: PopularMoviesControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        for subscriber in self.subscribers {
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
        
        if self.viewModel.apiManager.shouldFetchNextPage() {
            self.viewModel.apiManager.fetchNextPopularMoviesPage()
        }
        
        self.screen.moviesCollectionView.delegate = self
        self.screen.moviesCollectionView.dataSource = self
        self.screen.moviesCollectionView.prefetchDataSource = self
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search movies..."
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    // MARK: - Binding
    
    func bind(to viewModel: PopularMoviesControllerViewModel) {
        self.subscribers.append(viewModel.$numberOfMovies
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in
                self.screen.moviesCollectionView.reloadData()
            })
        )
        
        self.subscribers.append(viewModel.storageManager.$favorites
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in
                self.screen.moviesCollectionView.reloadData()
            })
        )
    }
}
