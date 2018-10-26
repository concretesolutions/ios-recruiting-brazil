//
//  DetailMoviesViewController.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

protocol DetailsMoviesDisplayLogic {
    func displayMovieDetailed(viewModel: DetailMovie.ViewModel.Success)
    func displayError(viewModel: DetailMovie.ViewModel.Error)
}

class DetailMoviesViewController: UIViewController {
    
    var interactor: DetailMoviesBusinessLogic!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        DetailMoviesSceneConfigurator.inject(dependenciesFor: self)
    }
    
    
}

extension DetailMoviesViewController: DetailsMoviesDisplayLogic {
    
    func displayMovieDetailed(viewModel: DetailMovie.ViewModel.Success) {
        print("🎀 viewModel in DetailMovies! \(viewModel.title)")
    }
    
    func displayError(viewModel: DetailMovie.ViewModel.Error) {
        
    }
    
}
