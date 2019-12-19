//
//  MoviesAPIManager.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

final class MoviesAPIManager {

    // MARK: - Properties
    
    internal let apiKey: String = "eea991e8b8c8738c849cddf195bc2813"
    internal let decoder: DTODecoder = DTODecoder()
    internal let session: NetworkSession
    internal var currentPage: Int = 0
        
    // MARK: - Publishers and Subscribers
    
    @Published var fetchStatus: FetchStatus = .none
    @Published var movies: [MovieDTO] = []
    @Published var genres: [GenreDTO] = []
    
    // MARK: - Enums
    
    enum FetchStatus {
        case none
        case completedFetchWithError
        case fetchingGenres
        case fetchingMovies
    }
    
    // MARK: - Initializers and Deinitializers
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
        self.fetchGenresList(completion: { completionStatus in
            if completionStatus == .none {
                self.fetchNextPopularMoviesPage()
            }
        })
    }
    
    // MARK: - Fetch methods
    
    func fetchGenresList(completion: ((FetchStatus) -> Void)? = nil) {
        self.fetchStatus = .fetchingGenres
        self.getGenres(completion: { (data, _) in
            if let data = data {
                self.genres = self.decoder.decodeGenres(from: data)
                self.fetchStatus = .none
            } else {
                self.fetchStatus = .completedFetchWithError
            }
            
            completion?(self.fetchStatus)
        })
    }
    
    func fetchNextPopularMoviesPage() {
        self.fetchStatus = .fetchingMovies
        self.getPopularMovies(page: self.currentPage + 1, completion: { (data, _) in
            if let data = data {
                self.currentPage += 1
                self.movies += self.decoder.decodePopularMovies(from: data)
                self.fetchStatus = .none
            } else {
                self.fetchStatus = .completedFetchWithError
            }
        })
    }
    
    func shouldFetchNextPage() -> Bool {
        return !self.shouldFetchGenres() && self.currentPage < 500 && !([.fetchingGenres, .fetchingMovies].contains(self.fetchStatus))
    }
    
    func shouldFetchGenres() -> Bool {
        return self.genres.count == 0
    }
    
    // MARK: - Request Methods
    
    func getPopularMovies(page: Int, completion: @escaping (Data?, Error?) -> Void) {
        self.session.getData(from: "https://api.themoviedb.org/3/movie/popular?page=\(page)&language=en-US&api_key=\(self.apiKey)", completion: completion)
    }
    
    func getGenres(completion: @escaping (Data?, Error?) -> Void) {
        self.session.getData(from: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(self.apiKey)&language=en-US", completion: completion)
    }
}
