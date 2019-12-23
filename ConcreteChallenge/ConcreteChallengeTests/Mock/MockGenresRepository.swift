//
//  MockGenresRepository.swift
//  ConcreteChallengeTests
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
@testable import ConcreteChallenge

struct MockGenresRepository: GenresRepository {
    
    var response: MockResponse
    
    func getAllGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        switch response {
        case .genres(let genres):
            completion(.success(genres))
        case .error(let error):
            completion(.failure(error))
        }
    }
    
    enum MockResponse {
        case genres([Genre])
        case error(Error)
    }
}
