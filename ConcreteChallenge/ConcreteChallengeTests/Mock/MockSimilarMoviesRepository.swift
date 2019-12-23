//
//  MockSimilarMoviesRepository.swift
//  ConcreteChallengeTests
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
@testable import ConcreteChallenge

class MockSimilarMoviesRepository: SimilarMoviesRepository {
    var similarMovieIdProvider: (() -> Int?)?
    
    func getMovies(fromPage page: Int, completion: @escaping (Result<Page<Movie>, Error>) -> Void) {
        
    }
}
