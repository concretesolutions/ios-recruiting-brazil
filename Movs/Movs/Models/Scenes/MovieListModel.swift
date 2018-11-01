//
//  MovieListModel.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

enum MovieList {
    enum Request {
        struct Page {
            var page: Int
        }
        
        struct Movie {
            var title: String
        }
    }
    
    struct Response {
        var movies: [Response.FetchResponse]
        var error: String?
        
        struct FetchResponse {
            var title: String
            var posterURL: String
            var isFavorite: Bool
        }
        
        struct FavoriteResponse {
            var title: String
            var posterURL: String
            var isFavorite: Bool
        }
        
        enum Status {
            case success
            case error
        }
    }
    
    struct ViewModel {
        struct Success {
            var movies: [ViewModel.Movie]
        }
        
        struct Movie {
            var title: String
            var posterURL: String
            var favoriteImageName: String
        }
        
        struct Error {
            var error: String
        }
    }
}
