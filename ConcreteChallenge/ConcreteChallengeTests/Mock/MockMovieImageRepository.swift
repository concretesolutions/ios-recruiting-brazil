//
//  MovieImageRepository.swift
//  ConcreteChallengeTests
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import Nimble
@testable import ConcreteChallenge

struct MockMovieImageRepository: MovieImageRepository {
    
    var response: MockResponse
    var cancelCompletion: (() -> Void)?
    
    func getImage(withPath path: String, completion: @escaping ((Result<URL, Error>) -> Void)) -> CancellCompletion {
    
        switch self.response {
        case .error(let error):
            completion(.failure(error))
        case .image(let url):
            completion(.success(url))
        }
        
        return cancelCompletion ?? {}
    }
    
    enum MockResponse {
        case image(URL)
        case error(Error)
    }
}

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
