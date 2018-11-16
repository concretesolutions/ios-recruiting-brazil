//
//  MovieDetailPresenter.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class MovieDetailPresenter: MovieDetailPresentation, MovieDetailInteractorOutput {
    
    
    // MARK: - Properties
    var view: MovieDetailView?
    var interactor: MovieDetailInteractorInput!
    var router: MovieDetailWireframe!
    
    var movie: Movie!
    
    // MARK: - MovieDetailPresentation functions
    func viewDidLoad() {
        self.interactor.fetchMovieDetails(movie: movie)
    }
    
    func didTapFavoriteButton(of movie: MovieDetails) {
        self.interactor.addMovieToFavorite(movie: movie)
    }
    
    // MARK: - MovieDetailInteractorOutput functions
    func didFetchMovieDetails(movieDetails: MovieDetails) {
        self.view?.showDetails(of: movieDetails)
    }
    
    func didAddMovieToFavorite() {
        
    }
}
