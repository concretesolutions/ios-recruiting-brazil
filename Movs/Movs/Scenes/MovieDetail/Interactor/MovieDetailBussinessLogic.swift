//
//  MovieDetailBussinessLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieDetailBussinessLogic {
    func fetchMovie(request: MovieDetail.Request)
    func favorite(movie: Movie)
}
