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
    private let genresDataSource: GenresDataSource = GenresDataSourceImpl()
    private var currentPage = 0

    func fetchNextPopularMovies() -> Single<[Movie]> {
        let popularMoviesObservable = moviesDataSource.fetchPopularMovies()
        let genresObservable = genresDataSource.fetchGenres()
            .map({ (genres: [Genre]) -> [Int: String] in
                var hashedGenres = [Int: String]()
                genres.forEach({ hashedGenres[$0.genreId] = $0.name })
                return hashedGenres
            })
        return Single.zip(popularMoviesObservable, genresObservable, resultSelector: { ($0, $1) })
            .map({ (movies: [Movie], genresList: [Int: String]) -> [Movie] in
                for movie in movies {
                    movie.genres = self.mapGenres(from: movie.genreIds, genresList: genresList)
                    if self.moviesDataSource.isMovieFavorited(movie) {
                        movie.isFavorited = true
                    }
                }
                return movies
            })
    }

    func fetchFavoritedMovies() -> Single<[Movie]> {
        return moviesDataSource.fetchFavoritedMovies()
    }

    func favoriteMovie(_ movie: Movie) -> Completable {
        return moviesDataSource.addToFavorites(movie)
    }

    func unfavoriteMovie(_ movie: Movie) -> Completable {
        return moviesDataSource.removefromFavorites(movie)
    }

    // MARK: - Map genres ids to their names

    /**
     Maps genre ids to their names
     */
    func mapGenres(from genreIds: [Int], genresList: [Int: String]) -> [String] {
        var genreNames = [String]()
        for genreId in genreIds {
            if let name = genresList[genreId] {
                genreNames.append(name)
            }
        }
        return genreNames
    }
}
