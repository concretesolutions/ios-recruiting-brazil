//
//  MovieNetworkRepositorySpy.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import XCTest
import RxSwift
@testable import TheMovies

class MovieNetworkRepositorySpy: MovieNetworkRepositoryProtocol {
    var callGetMoviesCount = 0
    
    private var publisher = PublishSubject<(Int, [MovieEntity])>()
    var getMoviesStream: Observable<(Int, [MovieEntity])> {
        return publisher.asObservable()
    }
    
    func getMovies(page: Int) {
        publisher.onNext((0, []))
        callGetMoviesCount+=1
    }
}
