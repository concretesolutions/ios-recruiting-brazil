//
//  DataProvider.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

protocol DataProvidable {
    var popularMovies: [Movie] { get set }
    var favoriteMovies: [Movie] { get }
}

class DataProvider: DataProvidable, ObservableObject {
    public static let shared = DataProvider()
    
    private var page: Int = 1
    
    @Published var popularMovies: [Movie] = []
    @Published var favoriteMovies: [Movie] = []
    
    init() {
        _ = UserDefaults.standard.publisher(for: \.favorites)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] favoritesIDs in
                self?.fetchFavorites(withIDs: favoritesIDs)
            })
    }
    
    // TO DO: Fix like the favorites
    public func fetchMovies(completion: @escaping (_ movies: [Movie]) -> Void) {
        
        MovieService.fecthMovies(params: ["page": "\(page)"]) { result in
            switch result {
            case .success(let response):
                self.page += 1 // Update current page to fetch
                
                let movies = response.results.map { Movie($0) } // Map response to array of movies
                completion(movies)

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
            self.favoriteMovies = favorites
        }
    }
}
