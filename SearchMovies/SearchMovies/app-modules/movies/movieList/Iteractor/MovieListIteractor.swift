//
//  MovieListIteractor.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class MovieListIteractor: PresenterToMovieListIteractorProtocol {
    var presenter: IteractorToMovieListPresenterProtocol?
    let service:MovieListService = MovieListService()
    func loadMovies() {
        service.getMovies(appKey: Constants.appKey, pageNumber: 1) { (result) in
            if result.typeReturnService == .success {
                let objectReturn:MovieListResult = result.objectReturn as! MovieListResult
                self.presenter?.returnMovies(movies: objectReturn.movies)
            }
            else {
                self.presenter?.returnMoviesError(message: result.messageReturn!)
            }
        }
    }
    
    
}
