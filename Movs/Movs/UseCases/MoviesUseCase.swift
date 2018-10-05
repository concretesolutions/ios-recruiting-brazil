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
class MoviesUseCase {

    private let moviesDataSource: MoviesDataSource = MoviesDataSourceImpl()
    private var currentPage = 0

    func fetchNextPopularMovies() -> Single<[Movie]> {
        return moviesDataSource.fetchPopularMovies()
            .map({ (movies: [Movie]) -> [Movie] in
                movies.forEach({ (movie: Movie) in
                    if self.moviesDataSource.isMovieFavorited(movie) {
                        movie.isFavorited = true
                    }
                })
                return movies
            })
    }

    func favoriteMovie(_ movie: Movie) -> Completable {
        return moviesDataSource.addToFavorites(movie)
    }

    func unfavoriteMovie(_ movie: Movie) -> Completable {
        return moviesDataSource.removefromFavorites(movie)
    }
}
