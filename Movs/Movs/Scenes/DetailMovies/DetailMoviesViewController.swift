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
    func displayMovieDetailed(viewModel: DetailMovieModel.ViewModel.Success)
    func displayError(viewModel: DetailMovieModel.ViewModel.Error)
}

protocol DetailMoviesFavoriteMovie {
    func setRawDetailedMovie(movie: MovieDetailed)
    func movieAddedToFavorite(message: String)
}

class DetailMoviesViewController: UIViewController {
    
    var interactor: (DetailMoviesBusinessLogic & FavoriteActionBusinessLogic)?
    
    @IBOutlet weak var posterImage: UIImageViewMovieCard!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var imdbValue: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Auxiliar variables
    private var movieRawData: MovieDetailed?
    var movieId: Int?
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        DetailMoviesSceneConfigurator.inject(dependenciesFor: self)
        setup()
        if let movieId = self.movieId {
            let request = DetailMovieModel.Request(movieId: movieId)
            interactor!.fetchMovieDetailed(request: request)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateFavoriteMovie()
    }
    
    // MARK: - Setup
    private func setup() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Detalhe"
        navigationItem.backBarButtonItem?.title = ""
    }
    
    // MARK: - Actions
    @IBAction func favoriteMovieAction(_ sender: Any) {
        
        if let movie = movieRawData {
            if !movie.isFavorite {
                let movie = MovieDetailed.init(id: movie.id, genres: movie.genres, genresNames: movie.genresNames, title: movie.title, overview: movie.overview, releaseDate: movie.releaseDate, posterPath: movie.posterPath, voteAverage: movie.voteAverage, isFavorite: movie.isFavorite)
                interactor?.addFavorite(movie: movie)
            }
        } else {
            // remove from favorites
            print("🐠  DetailVC: Detail movies trying to remove from favorite")
        }
    }
    
    func updateFavoriteMovie() {
        if let isFavorite = movieRawData?.isFavorite {
            if isFavorite {
                favoriteButton.setTitle("Desfavoritar", for: .normal)
            } else {
                favoriteButton.setTitle("Favoritar", for: .normal)
            }
        }
    }
    
}
// MARK: - Presentation logic
extension DetailMoviesViewController: DetailsMoviesDisplayLogic {
    
    func displayMovieDetailed(viewModel: DetailMovieModel.ViewModel.Success) {
        posterImage.kf.setImage(with: viewModel.posterPath)
        movieTitle.text = viewModel.title
        genres.text = viewModel.genreNames
        movieOverview.text = viewModel.overview
        imdbValue.text = viewModel.imdbVote
        favoriteIcon.image = viewModel.favoriteButtonImage
        year.text = viewModel.year
        updateFavoriteMovie()
    }
    
    func displayError(viewModel: DetailMovieModel.ViewModel.Error) {
        
    }
    
}

// MARK: - Add and remove from favorite action
extension DetailMoviesViewController: DetailMoviesFavoriteMovie {
    
    func setRawDetailedMovie(movie: MovieDetailed) {
        self.movieRawData = movie
    }
    
    func movieAddedToFavorite(message: String) {
        // Update the screen presentation
        updateFavoriteMovie()
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
