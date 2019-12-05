//
//  MoviesAPIManager.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

class MoviesAPIManager: MoviesAPIDataFetcher {

    // MARK: - Attributes
    
    private let apiKey: String = "eea991e8b8c8738c849cddf195bc2813"
    private let session: NetworkSession
    internal var genres: [GenreDTO] = []
    
    // MARK: - Initializers and Deinitializers
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
        self.fetchGenresList()
    }
    
    // MARK: - Fetch methods
    
    func fetchGenresList() {
        self.getGenres(completion: { (data, error) in
            if let data = data {
                do {
                    let genresList = try JSONDecoder().decode(GenresDTO.self, from: data)
                    self.genres = genresList.genres
                } catch {
                    print(error)
                }
            }
        })
    }
    
    // MARK: - Request Methods
    
    func getPopularMovies(page: Int, completion: @escaping (Data?, Error?) -> Void) {
        self.session.getData(from: "https://api.themoviedb.org/3/movie/popular?page=\(page)&language=en-US&api_key=\(self.apiKey)", completion: completion)
    }
    
    func getGenres(completion: @escaping (Data?, Error?) -> Void) {
        self.session.getData(from: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(self.apiKey)&language=en-US", completion: completion)
    }
    
    func getImage(path: String, widthSize: Int, completion: @escaping (Data?, Error?) -> Void) {
        self.session.getData(from: "https://image.tmdb.org/t/p/w\(widthSize)\(path)", completion: completion)
    }
}
