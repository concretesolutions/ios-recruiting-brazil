//
//  DetailMoviesModels.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

enum DetailMovieModel {
    // MARK: Use cases
    
    struct Request {
        let movieId: Int
    }
    
    enum Response {
        struct Success {
            let movie: MovieDetailed
        }
        
        struct Error {
            var image: UIImage?
            let message: String
        }
        
    }
    
    enum ViewModel {
        struct Success {
            let title: String
            let overview: String
            let genreNames: String
            let year: String
            let posterPath: URL
            let imdbVote: String
            let favoriteButtonImage: UIImage
        }
        
        struct Error {
            var image: UIImage?
            var message: String
        }
        
        struct MovieAddedToFavorite {
            let message: String
            let isFavorite: Bool
            let favoriteIcon: UIImage
        }
    }
    
    enum ErrorType {
        case connectionError
    }
    
}
