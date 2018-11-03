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
    func movieAddedToFavorite(viewModel: DetailMovieModel.ViewModel.MovieAddedToFavorite)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let movieId = self.movieId {
            let request = DetailMovieModel.Request(movieId: movieId)
            interactor!.fetchMovieDetailed(request: request)
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
        
        if let movie = movieRawData {
            if !movie.isFavorite {
                let movie = MovieDetailed.init(id: movie.id, genres: movie.genres, genresNames: movie.genresNames, title: movie.title, overview: movie.overview, releaseDate: movie.releaseDate, posterPath: movie.posterPath, voteAverage: movie.voteAverage, isFavorite: movie.isFavorite)
                interactor?.addFavorite(movie: movie)
            } else {
                interactor?.removeFavorite(movie: movie)
            }
        }
    }
    
    func updateFavoriteMovie(isFavorite: Bool) {
        movieRawData?.isFavorite = isFavorite
        if isFavorite {
            favoriteButton.setTitle("Desfavoritar", for: .normal)
        } else {
            favoriteButton.setTitle("Favoritar", for: .normal)
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
        year.text = viewModel.year
        favoriteIcon.image = viewModel.favoriteButtonImage
        updateFavoriteMovie(isFavorite: (movieRawData?.isFavorite)!)
    }
    
    func displayError(viewModel: DetailMovieModel.ViewModel.Error) {
        let viewError = MovieListErrorView(frame: view.frame, image: viewModel.image!, message: viewModel.message)
        view.addSubview(viewError)
    }
    
}

// MARK: - Add and remove from favorite action
extension DetailMoviesViewController: DetailMoviesFavoriteMovie {
    
    func setRawDetailedMovie(movie: MovieDetailed) {
        self.movieRawData = movie
    }
    
    func movieAddedToFavorite(viewModel: DetailMovieModel.ViewModel.MovieAddedToFavorite) {
        // Update the screen presentation
        updateFavoriteMovie(isFavorite: viewModel.isFavorite)
        favoriteIcon.image = viewModel.favoriteIcon
        let alertController = UIAlertController(title: nil, message: viewModel.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
