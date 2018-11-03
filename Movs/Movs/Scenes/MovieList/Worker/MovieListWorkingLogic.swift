//
//  MovieListWorkingLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieListWorkingLogic {
    /**
     Fetch movies by page
     
     - parameters:
         - page: Page to fetch movies from.
         - completion: Action to be made after fetch is completed
     */
    func fetch(page: Int, completion: @escaping (MoviesList, MovieList.Response.Status, Error?) -> ())
}
