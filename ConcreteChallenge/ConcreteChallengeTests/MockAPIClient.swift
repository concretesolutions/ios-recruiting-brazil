//
//  MockAPIClient.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 19/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Foundation
@testable import ConcreteChallenge

final class MockApiClient {
    func fetchGenres(completion: @escaping (Bool, GenreResponse?) -> Void) {
        let filePath = "GenreResponse"
        
        MockApiClient.loadJSONDataFromFile(filePath: filePath) { (result: Result<Data, Error>) in
            switch result {
            case .success(let response):
                let responseObject = try! JSONDecoder().decode(GenreResponse.self, from: response)
                completion(true, responseObject)
            case .failure:
                completion(false, nil)
            }
        }
    }
    
    func fetchMovies(completion: @escaping (Bool, MoviesResponse?) -> Void) {
        let filePath = "MoviesResponse"
        
        MockApiClient.loadJSONDataFromFile(filePath: filePath) { (result: Result<Data, Error>) in
            switch result {
            case .success(let response):
                let responseObject = try! JSONDecoder().decode(MoviesResponse.self, from: response)
                completion(true, responseObject)
            case .failure:
                completion(false, nil)
            }
        }
    }
    
    static func loadJSONDataFromFile(filePath: String, completion: @escaping (Result<Data, Error>) -> ()) {
        if let path = Bundle.main.path(forResource: filePath, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                completion(.success(data))
                
            } catch(let error) {
                completion(.failure(error))
            }
        }
    }
}
