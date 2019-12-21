//
//  PopularMoviesViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    private var viewModel: DefaultMoviesListViewModel
    private lazy var moviesListViewController = MoviesListViewController(viewModel: self.viewModel)
    
    init(viewModel: DefaultMoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        addChild(moviesListViewController, inView: view)
    }
}
