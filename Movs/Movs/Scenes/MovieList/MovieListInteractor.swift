//
//  MovieListInteractor.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieListBussinessLogic {
    func fetchMovies(request: MovieListModel.Request)
}

class MovieListInteractor: MovieListBussinessLogic {
    var presenter: MovieListPresentationLogic!
    var worker: MovieListWorker!
    
    init() {
        worker = MovieListWorker()
    }
    
    func fetchMovies(request: MovieListModel.Request) {
        worker.fetch(page: request.page) { (movieList, status, error) in
            switch status {
            case .success:
                let responses = movieList.results.map({ (movie) -> MovieListModel.Response.FetchResponse in
                    return MovieListModel.Response.FetchResponse(title: movie.title, posterURL: MovieService.baseImageURL + movie.posterPath, isFavorite: false)
                })
                let response = MovieListModel.Response(movies: responses, error: nil)
                self.presenter.presentMovies(response: response)
                
            case .error:
                let response = MovieListModel.Response(movies: [], error: error?.localizedDescription)
                self.presenter.presentError(response: response)
            }
            
        }
    }
    
}
