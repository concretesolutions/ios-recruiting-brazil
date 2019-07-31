//
//  GenreNetworkRepositorySpy.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import XCTest
import RxSwift
@testable import TheMovies

class GenreNetworkRepositorySpy: GenreNetworkRepositoryProtocol {
    var callGetGenresCount = 0
    
    private var publisher = PublishSubject<[Genre]>()
    var getGenresStream: Observable<[Genre]> {
        return publisher.asObservable()
    }
    
    func getGenres() {
        publisher.onNext([])
        callGetGenresCount+=1
    }
}
