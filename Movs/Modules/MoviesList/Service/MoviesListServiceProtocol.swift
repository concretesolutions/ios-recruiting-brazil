//
//  MoviesListServiceProtocol.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

protocol MoviesListServiceProtocol {
    func getMoviesList(completion: @escaping (Result<MoviesDTO, HTTPError>) -> Void)
}
