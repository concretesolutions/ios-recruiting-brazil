//
//  DataProvider.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation
import Combine

protocol DataProvidable {
    var popularMoviesPublisher: CurrentValueSubject<([Movie], Error?), Never> { get }
    var favoriteMoviesPublisher: CurrentValueSubject<([Movie], Error?), Never> { get }
    
    var popularMovies: [Movie] { get }
    var favoriteMovies: [Movie] { get }
    var genres: [Int: String] { get }
    
    func fetchPopularMovies(page: Int, completion: (() -> Void)?)
    func fetchFavoriteMovies(completion: (() -> Void)?)
    func searchMovie(query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
    func toggleFavorite(withId id: Int)
    func isFavorite(_ id: Int) -> Bool
}

class DataProvider: DataProvidable, ObservableObject {

    public static let shared = DataProvider()
    
    var popularMoviesPublisher = CurrentValueSubject<([Movie], Error?), Never>(([], nil))
    var favoriteMoviesPublisher = CurrentValueSubject<([Movie], Error?), Never>(([], nil))
    
    var popularMovies: [Movie] {
        return self.popularMoviesPublisher.value.0
    }
    
    var favoriteMovies: [Movie] {
        return self.favoriteMoviesPublisher.value.0
    }
    
    var genres: [Int: String] {
        return MovieService.genres
    }
    // Cancellables
    private var favoriteIdsSubscriber: AnyCancellable?
    
    init() {
        fetchPopularMovies(page: 1)
        
        favoriteIdsSubscriber = UserDefaults.standard.publisher(for: \.favorites)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] favoritesIDs in
                self?.fetchFavorites(withIDs: favoritesIDs)
            })
    }
    
    public func fetchPopularMovies(page: Int, completion: (() -> Void)? = nil) {
        MovieService.fecthMovies(params: ["page": "\(page)"]) { result in
            switch result {
            case .failure(let error):
                self.popularMoviesPublisher.send(([], error))
            case .success(let response):
                let movies = response.results.map { Movie($0) } // Map response to array of movies
                self.popularMoviesPublisher.send((movies, nil))

            }
            
            completion?()
        }
    }
    
    func fetchFavoriteMovies(completion: (() -> Void)?) {
        self.fetchFavorites(withIDs: UserDefaults.standard.favorites, completion: completion)
    }
    
    private func fetchFavorites(withIDs ids: [Int], completion: (() -> Void)? = nil) {
        let group = DispatchGroup()
        var favorites = [Movie]()
        var fetchError: Error?
        
        for id in ids {
            group.enter()
            
            MovieService.fecthMovie(withId: id) { result in
                switch result {
                case .failure(let error):
                    fetchError = error
                case .success(let movie):
                    favorites.append(movie)
                }
                
                group.leave()
            }
            
            if fetchError != nil {
                break
            }
        }
        
        group.notify(queue: .main) {
            if let error = fetchError {
                self.favoriteMoviesPublisher.send(([], error))
            } else {
                self.favoriteMoviesPublisher.send((favorites, nil))
            }
            
            completion?()
        }
    }
    
    func searchMovie(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        MovieService.searchMovie(query: query) { result in
            completion(result)
        }
    }
    
    // MARK: - Handle favorites
    func toggleFavorite(withId id: Int) {
        UserDefaults.standard.toggleFavorite(withId: id)
    }
    
    func isFavorite(_ id: Int) -> Bool {
        return UserDefaults.standard.isFavorite(id)
    }
}
