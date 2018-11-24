//
//  MovieDetailPresenter.swift
//  Movies
//
//  Created by Renan Germano on 24/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import Foundation

class MovieDetailPresenter: MovieDetailPresentation, MovieDetailInteractorOutput {
    
    // MARK: - Properties
    
    weak var view: MovieDetailView?
    var router: MovieDetailWireframe!
    var interactor: MovieDetailUseCase!
    
    // MARK: - MovieDetailPresentation protocol functions
    
    func viewDidLoad() {
        self.interactor.getMovie()
    }
    
    func didTapFavoriteButton(forMovie movie: Movie) {
        if movie.isFavorite {
            self.interactor.unfavorite(movie: movie)
        } else {
            self.interactor.favorite(movie: movie)
        }
    }
    
    // MARK: - MovieDetailInteractorOutput protocol functions
    
    func didGet(movie: Movie) {
        self.view?.present(movie: movie)
    }
    
}
