//
//  MovieDetailBussinessLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieDetailBussinessLogic {
    /**
     Fetch the details of a movie requested.
     
     - parameters:
         - request: Movie requested.
     */
    func fetchMovie(request: MovieDetail.Request)
    
    /**
     Favorite movie. If is already favorite, unfavorite.
     
     - parameters:
         - movie: Movie to be favorite.
     */
    func favorite(movie: Movie)
}
