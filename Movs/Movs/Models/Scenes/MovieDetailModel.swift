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
        var title: String
        var genre: String
        var overwiew: String
        var isFavorite: Bool
        var imageView: UIImageView
    }
    struct ViewModel {}
}
