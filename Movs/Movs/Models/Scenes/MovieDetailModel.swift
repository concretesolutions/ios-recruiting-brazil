//
//  MovieDetailModel.swift
//  Movs
//
//  Created by Ricardo Rachaus on 28/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

enum MovieDetail {
    struct Request {
        var movie: Movie
    }
    
    struct Response {
        var movie: MovieDetailed
        var imageView: UIImageView
        var isFavorite: Bool
    }
    
    struct ViewModel {
        var title: String
        var year: String
        var genre: String
        var overview: String
        var favoriteImage: UIImage
        var imageView: UIImageView
    }
}
