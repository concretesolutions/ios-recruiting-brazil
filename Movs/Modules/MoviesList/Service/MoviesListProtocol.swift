//
//  MoviesListProtocol.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

protocol MoviesListProtocol {
    func getMoviesList(completion: @escaping (Result<MoviesDTO, HTTPError>) -> Void)
}
