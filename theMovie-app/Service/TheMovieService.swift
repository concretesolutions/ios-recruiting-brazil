//
//  TheMovieService.swift
//  theMovie-app
//
//  Created by Adriel Alves on 18/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

protocol TheMovieService {
    
    func getMovies(page: Int, completion: @escaping (Result<PopularMovies, APIError>) -> Void)
}
