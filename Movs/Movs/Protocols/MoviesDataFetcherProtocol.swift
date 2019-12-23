//
//  MoviesDataFetcherProtocol.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 02/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

protocol MoviesDataFetcherProtocol {

    // MARK: - Data request methods

    func requestGenres(completion: @escaping (_ genres: [GenreDTO], _ error: Error?) -> Void)
    func requestPopularMovies(fromPage page: Int, completion: @escaping (_ movies: [PopularMovieDTO], _ error: Error?) -> Void)
    func requestMovieDetails(forId id: Int, completion: @escaping (_ movie: MovieDTO?, _ error: Error?) -> Void)
    func smallImageURL(forPath imagePath: String) -> String
    func bigImageURL(forPath imagePath: String) -> String
}
