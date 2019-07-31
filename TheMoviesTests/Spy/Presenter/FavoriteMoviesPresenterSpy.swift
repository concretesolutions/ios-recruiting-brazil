//
//  FavoriteMoviesPresenterSpy.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import TheMovies

class FavoriteMoviesPresenterSpy: FavoriteMoviesPresenterProtocol {
    var loadFavoriteMoviesStream: Observable<[Movie]> = PublishSubject().asObservable()
    
    var movieUnfavoritedStream: Observable<Movie> = PublishSubject().asObservable()
    
    var loadMoviesYearStream: Observable<Set<String>> = PublishSubject().asObservable()
    
    var loadMoviesGenresStream: Observable<[String]> = PublishSubject().asObservable()
    
    var setFilterStream: Observable<(String, String)> = PublishSubject().asObservable()
    
    var loadFavoriteMoviesCallCount = 0
    func loadFavoriteMovies() {
        loadFavoriteMoviesCallCount+=1
    }
    
    var unfavoriteMovieButtonWasTappedCallCount = 0
    func unfavoriteMovieButtonWasTapped(id: Int) {
        unfavoriteMovieButtonWasTappedCallCount+=1
    }
    
    var loadMoviesYearCallCount = 0
    func loadMoviesYear() {
        loadMoviesYearCallCount+=1
    }
    
    var loadMoviesGenresCallCount = 0
    func loadMoviesGenres() {
        loadMoviesGenresCallCount+=1
    }
    
    var filterResultsCallCount = 0
    func filterResults(with date: String, and genre: String) {
        filterResultsCallCount+=1
    }
}


