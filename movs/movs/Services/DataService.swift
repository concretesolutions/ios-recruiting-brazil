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
    
    // Favorites
    private(set) var favorites: [Movie] = []
    private var favoritesIDs: Set<Int> {
        get {
            return Set(UserDefaults.standard.array(forKey: "FavoritesIDs") as? [Int] ?? [])
        }
        
        set {
            UserDefaults.standard.set(Array(newValue), forKey: "FavoritesIDs")
        }
    }
    
    // MARK: - Shared instance
    static let shared = DataService()
    
    // MARK: - Initiliazer
    private init() {
        self.dataSource = MovieAPIService.self
    }
    
    // MARK: - Setup data service for tests
    func setup(with dataService: DataSource.Type = MovieAPIService.self) {
        self.dataSource = dataService.self
    }
    
    func reset() {
        self.genres = [:]
        self.movies = []
        self.favorites = []
    }
    
    // MARK: - Load methods
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
    
    func loadFavorites(completion: @escaping (CollectionState) -> Void) {
        let group = DispatchGroup()
        var hasFailed = false
        
        self.favoritesIDs.forEach { (id) in
            group.enter()
            
            if self.favorites.contains(where: { movie in movie.id == id }) {
                group.leave()
            } else if let movie = self.movies.first(where: { movie in movie.id == id }) {
                self.favorites.append(movie)
                group.leave()
            } else {
                self.dataSource.fetchMovieDetail(with: id) { (result) in
                    switch result {
                    case .failure:
                        hasFailed = true
                    case .success(let movieDetailDTO):
                        self.favorites.append(Movie(movie: movieDetailDTO))
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: DispatchQueue.main, execute: {
            if hasFailed {
                completion(.loadError)
            } else {
                completion(.loadSuccess)
            }
        })
    }
    
    func loadPosterImage(with urlString: String, completion: @escaping (UIImage) -> Void) {
        self.dataSource.fetchMoviePoster(with: urlString) { (result) in
            switch result {
            case .failure:
                completion(UIImage(named: "PosterUnavailabe")!)
            case .success(let image):
                completion(image)
            }
        }
    }
    
    // MARK: - Favorites
    func addToFavorites(_ id: Int) {
        self.favoritesIDs.insert(id)
    }
    
    func removeFromFavorites(_ id: Int) {
        self.favoritesIDs.remove(id)
        self.favorites.removeAll { (movie) -> Bool in
            return movie.id == id
        }
    }
    
    func movieIsFavorite(_ id: Int) -> Bool {
        return self.favoritesIDs.contains(id)
    }
}
