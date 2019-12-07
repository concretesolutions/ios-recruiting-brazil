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
    
    internal let screen = PopularMoviesViewScreen()
    internal let viewModel: PopularMoviesControllerViewModel
    
    // MARK: - Subscribers
    
    var moviesSubscriber: AnyCancellable?
    
    // MARK: - Initializers and Deinitializers
    
    deinit {
        self.moviesSubscriber?.cancel()
    }
    
    init(viewModel: PopularMoviesControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController life cycle
    
    override func loadView() {
        super.loadView()
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screen.moviesCollectionView.delegate = self
        self.screen.moviesCollectionView.dataSource = self
        self.screen.moviesCollectionView.prefetchDataSource = self
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bind(to: self.viewModel)
        
        if self.viewModel.shouldFetchMovies() {
            self.viewModel.fetchPopularMovies()
        }
    }
    
    // MARK: - Binding
    
    func bind(to viewModel: PopularMoviesControllerViewModel) {
        self.moviesSubscriber = viewModel.$numberOfMovies
            .receive(on: RunLoop.main)
            .sink(receiveValue: { _ in
                self.screen.moviesCollectionView.performBatchUpdates({
                    self.screen.moviesCollectionView.reloadSections(IndexSet(integer: 0))
                })
            })
    }
}
