//
//  MoviesAPIManager.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

class MoviesAPIManager: NSObject, MoviesAPIDataFetcher {

    // MARK: - Attributes
    
    private let apiKey: String = "eea991e8b8c8738c849cddf195bc2813"
    private let session: NetworkSession
    
    // MARK: - Initializers and Deinitializers
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Request Methods
    
    func getPopularMovies(page: Int, completion: @escaping (Data?, Error?) -> Void) {
        self.session.getData(from: "https://api.themoviedb.org/3/movie/popular?page=\(page)&language=en-US&api_key=\(self.apiKey)", completion: completion)
    }
    
    func getGenres(completion: @escaping (Data?, Error?) -> Void) {
        self.session.getData(from: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(self.apiKey)&language=en-US", completion: completion)
    }
}
