//
//  MoviePresenter.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 22/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

protocol MovieViewDelegate {
    func loadCollectionView(page: Int)
    func getMoreMovies()
    func getMovieDetails(movie: Movie)
}

class MoviePresenter: MovieViewDelegate {
    
    var viewController: MovieViewController
    weak var delegate: MovieViewPresenterDelegate?
    
    init(viewController: MovieViewController, delegate: MovieViewPresenterDelegate?) {
        self.viewController = viewController
        self.delegate = delegate
    }
    
    func loadCollectionView(page: Int) {
        
    }
    
    func getMoreMovies() {
        
    }
    
    func getMovieDetails(movie: Movie) {
        delegate?.selectedMovie(movie: movie)
    }
}
