//
//  MoviesGridPresenterMock.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import TheMovies

class MoviesGridPresenterSpy: MoviesGridPresenterProtocol {
    private var loadMoviesPublisher = PublishSubject<[Movie]>()
    var loadMoviesStream: Observable<[Movie]> {
        get {
            return loadMoviesPublisher.asObservable()
        }
    }
    
    private var reloadMoviesPublisher = PublishSubject<[Movie]>()
    var reloadMoviesStream: Observable<[Movie]> {
        get {
            return reloadMoviesPublisher.asObservable()
        }
    }
    
    var callLoadNewPageMoviesFromNetworkCount = 0
    func loadNewPageMoviesFromNetwork() {
        callLoadNewPageMoviesFromNetworkCount+=1
    }
    
    var callLoadMoviesFromCacheCount = 0
    func loadMoviesFromCache() {
        callLoadMoviesFromCacheCount+=1
    }
    
    var callMovieCellWasTappedCount = 0
    func movieCellWasTapped(id: Int) {
        callMovieCellWasTappedCount+=1
    }
    
    var callCacheGenresCount = 0
    func cacheGenres() {
        callCacheGenresCount+=1
    }
}
