//
//  FavoriteMoviesFiltersViewController.swift
//  Movs
//
//  Created by Gabriel D'Luca on 19/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class FavoriteMoviesFiltersViewController: UIViewController {
    
    // MARK: - Properties
    
    internal let viewModel: FavoriteMoviesFiltersControllerViewModel
    internal var screen = FavoriteMoviesFiltersViewScreen()
    
    // MARK: - Initializers and Deinitializers
    
    init(viewModel: FavoriteMoviesFiltersControllerViewModel) {
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel.coordinator?.finish()
    }
}
