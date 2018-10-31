//
//  ListMoviesModels.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.
//

import UIKit

enum ListMovies{

    struct Request {
        let page: Int
    }
    
    enum Response {
        struct Success {
            let movies: [PopularMovie]
        }
        
        struct Error {
            var image: UIImage?
            let description: String
            var errorType: FetchError
        }
    }
    
    enum ViewModel {
        struct Success {
            let movies: [PopularMoviesFormatted]
        }
        
        struct Error {
            var image: UIImage?
            var message: String
            var errorType: FetchError
        }
        
        struct PopularMoviesFormatted {
            let id: Int
            let title: String
            let overview: String
            var posterPath: URL
            var favoriteIcon: UIImage
            var isFavorite: Bool
        }
    }
    
}
