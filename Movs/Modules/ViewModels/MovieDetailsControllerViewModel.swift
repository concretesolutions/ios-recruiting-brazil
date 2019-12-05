// swiftlint:disable identifier_name

//
//  MovieDetailsControllerViewModel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class MovieDetailsControllerViewModel {
    
    // MARK: - Model
    
    private let movie: Movie
    
    // MARK: - Properties
    
    internal let apiManager: MoviesAPIManager
    internal let decoder = JSONDecoder()

    // MARK: - Attributes
    
    public let id: Int
    public var genresNames: Set<String>
    public let releaseYear: String
    public let title: String
    public let summary: String
    
    // MARK: - Publishers
    
    @Published var backdropImage: UIImage? = UIImage.from(color: .secondarySystemBackground)
    
    // MARK: - Initializers and Deinitializers
    
    init(movie: Movie, apiManager: MoviesAPIManager) {
        self.apiManager = apiManager
        self.movie = movie
        
        self.id = self.movie.id
        self.genresNames = Set(self.movie.genres.map({ $0.name }))
        print(self.genresNames)
        self.releaseYear = String(date: self.movie.releaseDate, components: [.year])
        self.title = self.movie.title
        self.summary = self.movie.summary
        
        if let imagePath = movie.backdropPath {
            self.fetchBackdropImage(path: imagePath)
        }
    }
    
    // MARK: - Fetch methods
    
    func fetchBackdropImage(path: String) {
        self.apiManager.getImage(path: path, widthSize: 780, completion: { (data, error) in
            if let data = data {
                self.backdropImage = UIImage(data: data)
            }
        })
    }
}
