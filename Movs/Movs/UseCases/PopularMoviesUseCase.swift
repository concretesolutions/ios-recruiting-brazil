//
//  PopularMoviesUseCase.swift
//  Movs
//
//  Created by Dielson Sales on 01/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

/**
 Handles the fetching of Movies and the "load more" feature.
 */
class PopularMoviesUseCase {

    private let moviesDataSource: MoviesDataSource = MoviesDataSourceImpl()
    private var currentPage = 0

    func fetchNextPopularMovies() -> Single<[Movie]> {
        return moviesDataSource.fetchPopularMovies()
    }
}
