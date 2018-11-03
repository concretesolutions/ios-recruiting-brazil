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
        struct RequestMovie {
            var title: String
        }
        
        struct Filtered {
            var movies: [Movie]
        }
    }
    
    struct Response {
        var movies: [Favorites.FavoritesMovie]
    }
    
    struct ViewModel {
        var movies: [Favorites.FavoritesMovie]
    }
    
    struct FavoritesMovie {
        var title: String
        var year: String
        var overview: String
        var imageView: UIImageView
    }
}
