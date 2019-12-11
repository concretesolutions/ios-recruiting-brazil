//
//  DataSourceProtocol.swift
//  movs
//
//  Created by Emerson Victor on 10/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

protocol DataSource {
    static func fetchGenres(completion: @escaping (Result<GenresDTO, Error>) -> Void)
    static func fetchPopularMovies(of page: Int, completion: @escaping (Result<MoviesRequestDTO, Error>) -> Void)
    static func fetchMoviePoster(withURL imageURL: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}
