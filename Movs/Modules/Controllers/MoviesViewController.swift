//
//  MoviesViewController.swift
//  Movs
//
//  Created by Gabriel D'Luca on 02/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import Combine

class MoviesViewController: UIViewController {

    // MARK: - Attributes and Properties
    
    internal let screen = MoviesViewScreen()
    internal let viewModel = MoviesControllerViewModel()
    
    // MARK: - Subscribers
    
    var moviesSubscriber: AnyCancellable?
    
    // MARK: - ViewController life cycle
    
    override func loadView() {
        super.loadView()
        self.view = self.screen
        self.screen.collectionDelegate = self
        self.bind(to: self.viewModel)
        self.title = "Home"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.requestMorePopularMovies()
    }
    
    func bind(to viewModel: MoviesControllerViewModel) {
        self.moviesSubscriber = viewModel.$numberOfMovies.sink(receiveValue: { _ in
            DispatchQueue.main.async {
                self.screen.moviesCollection.performBatchUpdates({
                    self.screen.moviesCollection.reloadSections(IndexSet(integer: 0))
                })
            }
        })
    }
}
