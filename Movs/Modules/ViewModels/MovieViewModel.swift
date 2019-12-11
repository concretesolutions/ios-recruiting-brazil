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
    
    typealias Dependencies = HasCoreDataManager
    internal let coreDataManager: CoreDataManager
    
    // MARK: - Properties
    
    weak var coordinatorDelegate: MovieDetailsCoordinator?
    
    // MARK: - Attributes
    
    public let backdropPath: String?
    public let id: Int
    public var genresNames: Set<String>
    public let posterPath: String?
    public let releaseYear: String
    public let title: String
    public let summary: String
    
    // MARK: - Initializers
    
    init(movie: Movie, dependencies: Dependencies) {
        self.movie = movie
        self.coreDataManager = dependencies.coreDataManager
        
        self.backdropPath = movie.backdropPath
        self.id = movie.id
        self.genresNames = Set(movie.genres.map({ $0.name }))
        self.posterPath = movie.posterPath
        self.releaseYear = String(date: movie.releaseDate, components: [.year])
        self.title = movie.title
        self.summary = movie.summary
    }
    
    // MARK: -
    
    func addToFavorites() {
        self.coreDataManager.addFavorite(movie: self.movie)
    }
    
    func removeFromFavorites() {
        self.coreDataManager.removeFavorite(movieID: Int64(self.id))
    }
}
