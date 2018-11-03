//
//  MovieListPresentationLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieListPresentationLogic {
    /**
     Present movies requested.
     
     - parameters:
         - response: Response for the movies requested.
     */
    func presentMovies(response: MovieList.Response)
    
    /**
     Present error for movies requested.
     
     - parameters:
        - response: Response for the movies requested.
     */
    func presentError(response: MovieList.Response)
    
    /**
     Present requested movie not find.
     
     - parameters:
        - response: Response for the movie requested.
     */
    func presentNotFind(response: MovieList.Response)
}
