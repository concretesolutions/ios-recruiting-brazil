//
//  FavoriteMoviesModel.swift
//  Movs
//
//  Created by Maisa on 27/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

enum FavoriteMoviesModel {
    
    enum Request {
        struct Remove {
            let movieId: Int
        }
    }
    
    enum Response {
        struct Success {
            let movie: MovieDetailed
            let genreNames: [String]
        }
        
        struct Error {
            let title: String
            let description: String
        }
    }
    
    enum ViewModel {
        struct Success {
            let title: String
            let overview: String
            let genreNames: String
            let year: String
            let posterPath: URL
        }
        
        struct Error {
            let title: String
            let description: String
        }
    }
}
