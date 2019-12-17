//
//  MoviesAPIManager.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

final class MoviesAPIManager: MoviesAPIDataFetcher {

    // MARK: - Properties
    
    internal let apiKey: String = "eea991e8b8c8738c849cddf195bc2813"
    internal let session: NetworkSession
    internal var genres: [GenreDTO] = []
    internal var isFetchInProgress: Bool = false
    internal var currentPage: Int = 0
    
    // MARK: - Publishers
    
    @Published var movies: [MovieDTO] = []
    
    // MARK: - Initializers and Deinitializers
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
        self.fetchGenresList()
    }
    
    // MARK: - Fetch methods
    
    func fetchGenresList() {
        self.isFetchInProgress = true
        self.getGenres(completion: { (data, error) in
            if let data = data {
                do {
                    let genresList = try JSONDecoder().decode(GenresDTO.self, from: data)
                    self.genres = genresList.genres
                } catch {
                    print(error)
                }
            }
            
            self.isFetchInProgress = false
        })
    }
    
    func fetchNextPopularMoviesPage() {
        self.isFetchInProgress = true
        self.getPopularMovies(page: self.currentPage + 1, completion: { (data, error) in
            if let data = data {
                do {
                    let popularMovies = try JSONDecoder().decode(PopularMoviesDTO.self, from: data)
                    self.currentPage = popularMovies.page
                    self.movies += popularMovies.results
                } catch {
                    print(error)
                }
            }
            
            self.isFetchInProgress = false
        })
    }
    
    func shouldFetchNextPage() -> Bool {
        return self.currentPage < 500 && !self.isFetchInProgress
    }
    
    // MARK: - Request Methods
    
    func getPopularMovies(page: Int, completion: @escaping (Data?, Error?) -> Void) {
        self.session.getData(from: "https://api.themoviedb.org/3/movie/popular?page=\(page)&language=en-US&api_key=\(self.apiKey)", completion: completion)
    }
    
    func getGenres(completion: @escaping (Data?, Error?) -> Void) {
        self.session.getData(from: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(self.apiKey)&language=en-US", completion: completion)
    }
}
