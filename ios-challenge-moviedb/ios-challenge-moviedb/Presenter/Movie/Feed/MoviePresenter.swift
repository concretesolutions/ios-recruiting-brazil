//
//  MoviePresenter.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 22/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit

protocol MovieViewDelegate: ErrorDelegate {
    var fetchingMoreMovies: Bool { get set }
    func reloadData()
}

class MoviePresenter {
    
    var movieView: MovieViewDelegate?
    weak var delegate: MovieViewPresenterDelegate?
    
    var movies: [Movie] = []
    var numberOfMovies: Int = 0
    private var currentPage: Int = 1
    private var maxNumberOfPages: Int = 0
    
    init() { }
    
    func loadCollectionView(page: Int) {
        MovieClient.getPopularMovies(page: currentPage) { [weak self] (popularMoviesResponse, error) in
            guard let `self` = self else { return }
            if let response = popularMoviesResponse {
                self.movies = response.movies
                self.currentPage = 1
                self.maxNumberOfPages = response.totalPages
                self.numberOfMovies = self.movies.count
                self.movieView?.reloadData()
            } else {
                self.movieView?.showError(imageName: Constants.ErrorValues.popularImageName, text: Constants.ErrorValues.popularMoviesText)
            }
        }
    }
    
    func getMoreMovies() {
        currentPage += 1
        print(currentPage)
        self.movieView?.fetchingMoreMovies = true
        MovieClient.getPopularMovies(page: currentPage) { [weak self] (popularMoviesResponse, error) in
            guard let `self` = self else { return }
            if let response = popularMoviesResponse {
                for movie in response.movies {
                    self.movies.append(movie)
                }
                self.maxNumberOfPages = response.totalPages
                self.numberOfMovies = self.movies.count
                self.movieView?.reloadData()
                print("deu bom")
            }
        }
    }
    
    func getMovieImageURL(width: Int, path: String) -> URL? {
        let imageURL = ImagesEndpoint.movieImage(width: width, path: path).imageUrl
        return imageURL
    }
    
    func showMovieDetails(movie index: Int) {
        let selectedMovie = movies[index]
        delegate?.selectedMovie(movie: selectedMovie)
    }
}

extension MoviePresenter: FavoriteMoviesProtocol {
    func isMovieFavorite(movie: Movie) -> Bool {
        let favoriteMovies = LocalData.object.getAllFavoriteMovies()
        if favoriteMovies[movie.id] == nil {
            return false
        }
        return true
    }
    
    func handleMovieFavorite(movie: Movie) {
        if isMovieFavorite(movie: movie) == false {
            LocalData.object.makeMovieFavorite(movie: movie)
        } else {
            LocalData.object.makeMovieNotFavorite(movie: movie)
        }
    }
    
    func changeButtonImage(button: UIButton, movie: Movie) {
        let isFavorite = isMovieFavorite(movie: movie)
        if isFavorite == true {
            button.setImage(UIImage(named: Constants.FavoriteButton.imageNamedFull), for: .normal)
        } else {
            button.setImage(UIImage(named: Constants.FavoriteButton.imageNamedNormal), for: .normal)
        }
    }
}
