//
//  MockFavoriteMovieHandlerRepository.swift
//  ConcreteChallengeTests
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
@testable import ConcreteChallenge

struct MockFavoriteMovieHandlerRepository: FavoriteMovieHandlerRepository {
    
    var response: MockReponse
    
    var addMovieToFavoriteCompletion: (( (ActionResult<Error>) -> Void ) -> Void)?
    var removeMovieFromFavoriteCompletion: (( (ActionResult<Error>) -> Void ) -> Void)?
    
    func movieIsFavorite(_ movie: Movie, completion: @escaping (Result<Bool, Error>) -> Void) {
        switch response {
        case .favorite(let response):
            completion(.success(response))
        case .error(let error):
            completion(.failure(error))
        }
    }
    
    func addMovieToFavorite(_ movie: Movie, completion: @escaping (ActionResult<Error>) -> Void) {
        addMovieToFavoriteCompletion?(completion)
    }
    
    func removeMovieFromFavorite(movieID: Int, completion: @escaping (ActionResult<Error>) -> Void) {
        removeMovieFromFavoriteCompletion?(completion)
    }
    
    enum MockReponse {
        case favorite(Bool)
        case error(Error)
    }
}
