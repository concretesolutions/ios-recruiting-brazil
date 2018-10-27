//
//  MovieListFetchWorker.swift
//  ShitMov
//
//  Created by Miguel Nery on 23/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

protocol MovieFetcher {
    func fetchPopularMovies(page: Int, _ completion: @escaping (Result<[Movie]>) -> Void)
}
