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

    // MARK: - Attributes and Properties
    
    internal let screen = MoviesViewScreen()
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
        self.screen.collectionDelegate = self
        self.title = "Home"
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
