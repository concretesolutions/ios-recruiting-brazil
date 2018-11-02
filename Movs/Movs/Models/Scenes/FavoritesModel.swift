//
//  FavoritesModel.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

enum Favorites {
    struct Request {
        struct Movie {
            var title: String
        }
    }
    
    struct Response {
        var movies: [Favorites.Movie]
    }
    
    struct ViewModel {
        var movies: [Favorites.Movie]
    }
    
    struct Movie {
        var title: String
        var year: String
        var overview: String
        var imageView: UIImageView
    }
}
