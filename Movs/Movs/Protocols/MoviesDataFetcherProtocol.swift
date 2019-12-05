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

    func requestGenres(completion: @escaping (_ genres: [Int: String], _ error: Error?) -> Void)
    func requestPopularMovies(fromPage page: Int, completion: @escaping (_ movies: [PopularMovieDTO], _ error: Error?) -> Void)
    func requestSmallImage(withPath imagePath: String, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void)
    func requestBigImage(withPath imagePath: String, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void)
}

extension MoviesDataFetcherProtocol {

    // Optional setup function
    func setup(completion: @escaping (_ error: Error?) -> Void) {
        completion(nil)
    }
}
