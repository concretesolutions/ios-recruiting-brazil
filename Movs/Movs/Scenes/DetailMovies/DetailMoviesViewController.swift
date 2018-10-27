//
//  DetailMoviesViewController.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit
import Kingfisher

protocol DetailsMoviesDisplayLogic {
    func displayMovieDetailed(viewModel: DetailMovie.ViewModel.Success)
    func displayError(viewModel: DetailMovie.ViewModel.Error)
}

class DetailMoviesViewController: UIViewController {
    
    var interactor: DetailMoviesBusinessLogic!
    
    @IBOutlet weak var posterImage: UIImageViewMovieCard!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var imdbValue: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var viewModel: DetailMovie.ViewModel?
    var movieId: Int?
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        DetailMoviesSceneConfigurator.inject(dependenciesFor: self)
        setup()
        if let movieId = self.movieId {
            let request = DetailMovie.Request(movieId: movieId)
            interactor.fetchMovieDetailed(request: request)
        }
    }
    
    
    // MARK: - Setup
    private func setup() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Detalhe"
        navigationItem.backBarButtonItem?.title = ""
    }
    
    // MARK: - Actions
    @IBAction func favoriteMovieAction(_ sender: Any) {
        
    }
    
    
}

extension DetailMoviesViewController: DetailsMoviesDisplayLogic {
    
    func displayMovieDetailed(viewModel: DetailMovie.ViewModel.Success) {
        print("🎀 viewModel in DetailMovies! \(viewModel.title)")
        
        
        
    }
    
    func displayError(viewModel: DetailMovie.ViewModel.Error) {
        
    }
    
}
