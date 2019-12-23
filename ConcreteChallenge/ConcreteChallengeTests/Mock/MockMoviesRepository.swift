//
//  MockMoviesListViewModel.swift
//  ConcreteChallengeTests
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
@testable import ConcreteChallenge

class MockMoviesRepository: MoviesRepository {
    
    var response: MockResponse
    var getMoviesCalledCompletion: (() -> Void)?
    
    private var currentPageNumber = 0
    
    init(response: MockResponse) {
        self.response = response
    }
    
    func getMovies(fromPage page: Int, completion: @escaping (Result<Page<Movie>, Error>) -> Void) {
        
        getMoviesCalledCompletion?()
        switch response {
        case .pages(let pages):
            guard currentPageNumber < pages.count else {
                completion(.failure(MockError()))
                return
            }
            completion(.success(pages[currentPageNumber]))
            currentPageNumber += 1
        case .error(let error):
            completion(.failure(error))
        }
    }
    
    enum MockResponse {
        case pages([Page<Movie>])
        case error(Error)
    }
}
