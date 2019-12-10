//
//  MoviesAPIManagerProtocol.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

protocol MoviesAPIDataFetcher {
    
    // MARK: - Properties
    
    var apiKey: String { get }
    var session: NetworkSession { get }
    
    // MARK: - Request Methods
    
    func getPopularMovies(page: Int, completion: @escaping (Data?, Error?) -> Void)
    func getGenres(completion: @escaping (Data?, Error?) -> Void)
}
