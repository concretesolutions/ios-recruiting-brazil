//
//  DataService.swift
//  movs
//
//  Created by Emerson Victor on 03/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

final class DataService {
    
    // MARK: - Attributes
    private(set) var genres: [Int: String] = [:]
    private(set) var dataSource: DataSource.Type
    // Movies
    private(set) var movies: [Movie] = []
    
//    // Favorites
////    private var favoritesIDs: [Int]
//    private var favorites: [Movie] = []
//    var favoritesCount: Int {
//        return self.favorites.count
//    }
    
    // MARK: - Shared instance
    static let shared = DataService()
    
    // MARK: - Initiliazer
    private init() {
        self.dataSource = MovieAPIService.self
    }
    
    // MARK: - Setup data service for tests
    func setup(with dataService: DataSource.Type) {
        self.dataSource = dataService.self
    }
    
    // MARK: - Support methods
    func loadMovies(of page: Int, completion: @escaping (CollectionState) -> Void) {
        if page == 1 {
            self.dataSource.fetchGenres { (result) in
                switch result {
                case .failure:
                    completion(.loadError)
                case .success(let genresDTO):
                    genresDTO.genres.forEach { (genre) in
                        self.genres[genre.id] = genre.name
                    }

                    MovieAPIService.fetchPopularMovies(of: page) { (result) in
                        switch result {
                        case .failure:
                            completion(.loadError)
                        case .success(let moviesRequest):
                            let movies = moviesRequest.movies.map { (movieDTO) -> Movie in
                                return Movie(movie: movieDTO)
                            }
                            self.movies.append(contentsOf: movies)
                            completion(.loadSuccess)
                        }
                    }
                }
            }
        } else {
            self.dataSource.fetchPopularMovies(of: page) { (result) in
                switch result {
                case .failure:
                    completion(.loadError)
                case .success(let moviesRequest):
                    let movies = moviesRequest.movies.map { (movieDTO) -> Movie in
                        return Movie(movie: movieDTO)
                    }
                    self.movies.append(contentsOf: movies)
                    completion(.loadSuccess)
                }
            }
        }
    }
    
    func loadPosterImage(withURL urlString: String, completion: @escaping (UIImage) -> Void) {
        self.dataSource.fetchMoviePoster(withURL: urlString) { (result) in
            switch result {
            case .failure:
                completion(UIImage(named: "PosterUnavailabe")!)
            case .success(let image):
                completion(image)
            }
        }
    }
}
