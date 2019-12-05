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
    internal let viewModel = MoviesControllerViewModel()
    
    // MARK: - Subscribers
    
    var moviesSubscriber: AnyCancellable?
    
    // MARK: - Initializers and Deinitializers
    
    deinit {
        self.moviesSubscriber?.cancel()
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
    
    func bind(to viewModel: MoviesControllerViewModel) {
        self.moviesSubscriber = viewModel.$numberOfMovies.sink(receiveValue: { _ in
            DispatchQueue.main.async {
                self.screen.moviesCollectionView.performBatchUpdates({
                    self.screen.moviesCollectionView.reloadSections(IndexSet(integer: 0))
                })
            }
        })
    }
}
