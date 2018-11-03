//
//  FetchPopularMoviesMock.swift
//  MovsTests
//
//  Created by Maisa on 02/11/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

@testable import Movs

class ListMoviesWorkerMock: ListMoviesWorkerProtocol {
    
    var fetchedMovies: MovieList?
    public var error: FetchError?
    
    public var mockPopularMovies = (0..<3).map { id in
        return PopularMovie(id: 123, genresId: [1,5,7], title: "Title", overview: "A short overview", releaseDate: "2018-10-10", posterPath: "ajasd", voteAverage: 8.0, isFavorite: false)
    }

    func fetchPopularMovies(request: ListMovies.Request,
                            success successCallback: @escaping (MovieList) -> (),
                            error errorCallback: @escaping (FetchError) -> (),
                            failure failureCallback: @escaping (FetchError) -> ()) {
        if request.page > 0 {
            fetchedMovies = MovieList(movies: mockPopularMovies)
            successCallback(fetchedMovies!)
        } else {
            errorCallback(FetchError.serverError)
        }
        if let _ = error {
            failureCallback(FetchError.networkFailToConnect)
        }
    }
    
}
