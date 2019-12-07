// swiftlint:disable identifier_name

//
//  MovieCellViewModel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class MovieCellViewModel {
    
    // MARK: - Model
    
    private let movie: Movie
    
    // MARK: - Properties
    
    internal let apiManager: MoviesAPIManager
    internal let decoder = JSONDecoder()
    
    // MARK: - Attributes
    
    public let id: Int
    public let posterPath: String?
    public let releaseYear: String
    public let title: String
    public let summary: String
    
    // MARK: - Initializers
    
    init(movie: Movie, apiManager: MoviesAPIManager) {
        self.movie = movie
        self.apiManager = apiManager
        
        self.id = movie.id
        self.posterPath = movie.posterPath
        self.releaseYear = String(date: movie.releaseDate, components: [.year])
        self.title = movie.title
        self.summary = movie.summary
    }
}
