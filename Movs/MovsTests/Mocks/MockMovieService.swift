//
//  MockMovieService.swift
//  MovsTests
//
//  Created by Bruno Barbosa on 29/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation
@testable import Movs

class MockMovieService: MovieServiceProtocol {
    init() {}
    static var shared: MovieServiceProtocol = MockMovieService()
    
    var popularMovies: [Movie] = []
    var favoriteMovies: [Movie] = []
    
    func fetchPopularMovies(completion: @escaping MoviesListCompletionBlock) {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "popularMovies", ofType: "json")
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
            let decoder = JSONDecoder()
            let response = try decoder.decode(APIResponse.self, from: jsonData)
            self.popularMovies = response.results
            completion(nil, self.popularMovies)
        } catch {
            completion(.genericError, [])
        }
    }
    
    func fetchFavoriteMovies(completion: MoviesListCompletionBlock?) {
        // TODO
    }
    
    func toggleFavorite(for movie: Movie, completion: SuccessOrErrorCompletionBlock?) {
        // TODO
    }
    
    func isFavorite(movie: Movie) -> Bool {
        // TODO
        return false
    }
    
    func getGenresString(for movie: Movie) -> String {
        // TODO
        return ""
    }
    
    
}
