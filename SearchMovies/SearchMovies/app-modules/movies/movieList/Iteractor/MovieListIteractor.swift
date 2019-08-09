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
    func loadMovies(page:Int) {
        service.getMovies(appKey: Constants.appKey, pageNumber: page) { (result) in
            if result.typeReturnService == .success {
                let objectReturn:MovieListResult = result.objectReturn as! MovieListResult
                self.presenter?.returnMovies(movies: objectReturn.movies, moviesTotal: objectReturn.moviesTotal)
            }
            else {
                self.presenter?.returnMoviesError(message: result.messageReturn!)
            }
        }
    }
    
    func loadGenrers() {
        let serviceGenre:GenreService = GenreService()
        serviceGenre.getGenres(appKey: Constants.appKey) { (result) in
            if result.typeReturnService == .success {
                let objectReturn:GenreListData = result.objectReturn as! GenreListData
                self.presenter?.returnLoadGenrers(genres: objectReturn.genres)
            }
            else {
                self.presenter?.returnMoviesError(message: result.messageReturn!)
            }
        }
    }
    
}
