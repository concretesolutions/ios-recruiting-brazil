//
//  MovieDetailsPresenterSpy.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import TheMovies

class MovieDetailsPresenterSpy: MovieDetailsPresenterProtocol {
    private var loadMovieDetailPublisher = PublishSubject<[Movie]>()
    var loadMovieDetailStream: Observable<[Movie]> {
        get {
            return loadMovieDetailPublisher.asObservable()
        }
    }
    
    private var movieWasFavoritedPublisher = PublishSubject<Movie>()
    var movieWasFavoritedStream: Observable<Movie> {
        get {
            return movieWasFavoritedPublisher.asObservable()
        }
    }
    
    var callLoadMovieDetailCount = 0
    func loadMovieDetail(id: Int) {
        callLoadMovieDetailCount+=1
    }
    
    var callFavoriteMovieButtonWasTappedCount = 0
    func favoriteMovieButtonWasTapped(id: Int) {
        callFavoriteMovieButtonWasTappedCount+=1
    }
}

