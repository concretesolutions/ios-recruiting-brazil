//
//  DataSourceMock.swift
//  movsSnapshotTests
//
//  Created by Emerson Victor on 18/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit
@testable import Movs

final class DataSourceMock: DataSource {
    static func fetchGenres(completion: @escaping (Result<GenresDTO, Error>) -> Void) {
        
    }
    
    static func fetchPopularMovies(of page: Int, completion: @escaping (Result<MoviesRequestDTO, Error>) -> Void) {
        
    }
    
    static func fetchMoviePoster(with imageURL: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
    }
    
    static func fetchMovieDetail(with id: Int, completion: @escaping (Result<MovieDetailDTO, Error>) -> Void) {
        
    }
}
