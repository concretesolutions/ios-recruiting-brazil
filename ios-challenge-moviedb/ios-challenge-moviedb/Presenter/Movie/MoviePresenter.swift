//
//  MoviePresenter.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 22/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

protocol MovieViewDelegate {
    func reloadData()
    func loadCollectionView(page: Int)
    func getMovieImageURL(width: Int, path: String) -> URL?
    func getMoreMovies()
    func showMovieDetails(movie: Movie)
}

class MoviePresenter: MovieViewDelegate {
    
    var viewController: MovieViewController
    weak var delegate: MovieViewPresenterDelegate?
    
    var movies: [Movie] = []
    var numberOfMovies: Int = 0
    private var currentPage: Int = 1
    private var maxNumberOfPages: Int = 0
    
    init(viewController: MovieViewController, delegate: MovieViewPresenterDelegate?) {
        self.viewController = viewController
        self.delegate = delegate
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController.movieCollectionView.reloadData()
        }
    }
    
    func loadCollectionView(page: Int) {
        MovieClient.getPopularMovies(page: currentPage) { [weak self] (popularMoviesResponse, error) in
            guard let `self` = self else { return }
            if let response = popularMoviesResponse {
                self.movies = response.movies
                self.currentPage = 1
                self.maxNumberOfPages = response.totalPages
                self.numberOfMovies = self.movies.count
                self.reloadData()
            } else {
                // Tratar o Erro
            }
        }
    }
    
    func getMoreMovies() {
        
    }
    
    func getMovieImageURL(width: Int, path: String) -> URL? {
        let imageURL = ImagesEndpoint.movieImage(width: width, path: path).imageUrl
        return imageURL
    }
    
    func showMovieDetails(movie: Movie) {
        delegate?.selectedMovie(movie: movie)
    }
}
