//
//  MovieDescriptionManager.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 02/11/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation

protocol MovieDescriptionInterfaceProtocol {
    func set(imageURL: String, title: String, year: Int, genres: [Genre], isSaved: Bool)
}

class MovieDescriptionManager {
    var interface: MovieDescriptionInterfaceProtocol?
    var movieProvider = MovieProvider()
    
    var movie: Movie?
    
    init(_ interface: MovieDescriptionInterfaceProtocol) {
        self.interface = interface
    }
    
    func load() {
        
        if let movie = self.movie {
            self.interface?.set(imageURL: Network.manager.imageDomainHigh + movie.imageUrl, title: movie.title, year: movie.year, genres: Array(movie.genres), isSaved: movie.isSaved)
            
        }
    }
    
    func save() {
        if let movie = self.movie {
            self.movieProvider.handle(movie: movie)
        }
    }
    
    func set(movie: Movie) {
        self.movie = movie
    }
    
}
