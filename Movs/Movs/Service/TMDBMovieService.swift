//
//  TMDBMovieService.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

class TMDBMovieService: MovieServiceProtocol {
    private init() {}
    static private(set) var shared: MovieServiceProtocol = TMDBMovieService()
    
    private(set) var popularMovies: [Movie] = []
    private(set) var favoriteMovies: [Movie] = []
    
    func fetchPopularMovies(completion: @escaping MoviesListCompletionBlock) {
        // TODO: implement API request
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.popularMovies = [
                Movie(withTitle: "Steve Universe: The Movie", andPoster: "stevenPoster", andReleaseDate: "2019-10-18", andGenreIds: [80, 19, 53], andOverview: "Two years after the events of 'Change Your Mind', Steven (now 16 years old) and his friends are ready to enjoy the rest of their lives peacefully. However, all of that changes when a new sinister Gem arrives, armed with a giant drill that saps the life force of all living things on Earth. In their biggest challenge ever, the Crystal Gems must work together to save all organic life on Earth within 48 hours.", isFavorite: false),
                Movie(withTitle: "Steve Universe Future", andPoster: "stevenPoster", andReleaseDate: "2019-10-18", andGenreIds: [80, 19, 53], andOverview: "Two years after the events of 'Change Your Mind', Steven (now 16 years old) and his friends are ready to enjoy the rest of their lives peacefully. However, all of that changes when a new sinister Gem arrives, armed with a giant drill that saps the life force of all living things on Earth. In their biggest challenge ever, the Crystal Gems must work together to save all organic life on Earth within 48 hours.", isFavorite: false),
                Movie(withTitle: "Steve Universe", andPoster: "stevenPoster", andReleaseDate: "2019-10-18", andGenreIds: [80, 19, 53], andOverview: "Two years after the events of 'Change Your Mind', Steven (now 16 years old) and his friends are ready to enjoy the rest of their lives peacefully. However, all of that changes when a new sinister Gem arrives, armed with a giant drill that saps the life force of all living things on Earth. In their biggest challenge ever, the Crystal Gems must work together to save all organic life on Earth within 48 hours.", isFavorite: true),
                Movie(withTitle: "Steve", andPoster: "stevenPoster", andReleaseDate: "2019-10-18", andGenreIds: [80, 19, 53], andOverview: "Two years after the events of 'Change Your Mind', Steven (now 16 years old) and his friends are ready to enjoy the rest of their lives peacefully. However, all of that changes when a new sinister Gem arrives, armed with a giant drill that saps the life force of all living things on Earth. In their biggest challenge ever, the Crystal Gems must work together to save all organic life on Earth within 48 hours.")
            ]
            completion(nil, self.popularMovies)
        }
    }
    
    func fetchFavoriteMovies(completion: @escaping MoviesListCompletionBlock) {
        // TODO: implement API request
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.favoriteMovies = [
                Movie(withTitle: "Steve Universe", andPoster: "stevenPoster", andReleaseDate: "2019-10-18", andGenreIds: [80, 19, 53], andOverview: "Two years after the events of 'Change Your Mind', Steven (now 16 years old) and his friends are ready to enjoy the rest of their lives peacefully. However, all of that changes when a new sinister Gem arrives, armed with a giant drill that saps the life force of all living things on Earth. In their biggest challenge ever, the Crystal Gems must work together to save all organic life on Earth within 48 hours.", isFavorite: true)
            ]
            completion(nil, self.favoriteMovies)
        }
    }
    
    func toggleFavorite(for movie: Movie, completion: SuccessOrErrorCompletionBlock?) {
        // TODO: save favorite status
        if (movie.isFavorite) {
            self.favoriteMovies.removeAll { (curMovie) -> Bool in
                curMovie.id == movie.id
            }
        } else {
            self.favoriteMovies.append(movie)
        }
        
        movie.isFavorite = !movie.isFavorite
        NotificationCenter.default.post(name: .didUpdateFavoritesList, object: self)
        
        // call calback with success status and/or error
        completion?(true, nil)
    }
}
