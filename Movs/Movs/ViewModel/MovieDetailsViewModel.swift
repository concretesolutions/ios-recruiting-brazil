//
//  MovieDetailsViewModel.swift
//  Movs
//
//  Created by Lucca Ferreira on 04/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import Combine
import UIKit

protocol MovieProtocol {}

class MovieDetailsViewModel: MovieProtocol {

    var title: String
    var overview: String
    var releaseDate: String
    var posterImage: UIImage

    init(withMovie movie: Movie) {
        self.title = movie.title
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.posterImage = movie.posterImage
    }

}
