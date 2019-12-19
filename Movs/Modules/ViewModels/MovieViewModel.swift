// swiftlint:disable identifier_name

//
//  MovieViewModel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class MovieViewModel {
    
    // MARK: - Model
    
    private let movie: Movie    
    
    // MARK: - Dependencies
    
    typealias Dependencies = HasStorageManager
    internal let storageManager: StorageManager
    
    // MARK: - Attributes
    
    public let backdropPath: String?
    public let id: Int
    public let genresNames: Set<String>
    public let posterPath: String?
    public var releaseYear: String {
        if let movieRelease = self.movie.releaseDate {
            return String(date: movieRelease, format: "YYYY")
        }
        return "Unknown"
    }    
    public let title: String
    public var summary: String {
        if let movieSummary = self.movie.summary {
            return movieSummary
        }
        return "Unavailable"
    }
    
    // MARK: - Initializers
    
    init(movie: Movie, dependencies: Dependencies) {
        self.movie = movie
        self.storageManager = dependencies.storageManager
        
        self.backdropPath = movie.backdropPath
        self.id = movie.id
        self.genresNames = Set(movie.genres.map({ $0.name }))
        self.posterPath = movie.posterPath
        self.title = movie.title
    }
    
    // MARK: - Storage Manager helpers
    
    func addToFavorites() {
        self.storageManager.addFavorite(movie: self.movie)
    }
    
    func removeFromFavorites() {
        self.storageManager.removeFavorite(movieID: Int64(self.id))
    }
    
    func getFavoriteStatus() -> Bool {
        return self.storageManager.isFavorited(movieID: self.id)
    }
}
