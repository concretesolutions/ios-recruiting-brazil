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
    var popularMoviesPublisher: CurrentValueSubject<[Movie], Never> { get }
    var favoriteMoviesPublisher: CurrentValueSubject<[Movie], Never> { get }
    
    var popularMovies: [Movie] { get }
    var favoriteMovies: [Movie] { get }
    
    func toggleFavorite(withId id: Int)
    func isFavorite(_ id: Int) -> Bool
}

class DataProvider: DataProvidable, ObservableObject {
    
    public static let shared = DataProvider()
    
    var popularMoviesPublisher = CurrentValueSubject<[Movie], Never>([])
    var favoriteMoviesPublisher = CurrentValueSubject<[Movie], Never>([])
    
    var popularMovies: [Movie] {
        return self.popularMoviesPublisher.value
    }
    
    var favoriteMovies: [Movie] {
        return self.favoriteMoviesPublisher.value
    }
    
    private var page: Int = 1
    
    // Cancellables
    private var favoriteIdsSubscriber: AnyCancellable?
    
    init() {
        fetchMovies()
        
        favoriteIdsSubscriber = UserDefaults.standard.publisher(for: \.favorites)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] favoritesIDs in
                self?.fetchFavorites(withIDs: favoritesIDs)
            })
    }
    
    public func fetchMovies() {
        MovieService.fecthMovies(params: ["page": "\(page)"]) { result in
            switch result {
            case .success(let response):
                self.page += 1 // Update current page to fetch
                
                let movies = response.results.map { Movie($0) } // Map response to array of movies
                self.popularMoviesPublisher.send(movies)

            case .failure(let error):
                print(error) // TO DO: Handle error
            }
        }
    }
    
    public func fetchFavorites(withIDs ids: [Int]) {
        let group = DispatchGroup()
        var favorites = [Movie]()
        
        for id in ids {
            group.enter()
            
            MovieService.fecthMovie(withId: id) { result in
                switch result {
                case .failure(let error):
                    print(error) // TO DO: Handle error
                case .success(let movie):
                    favorites.append(movie)
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.favoriteMoviesPublisher.send(favorites)
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
