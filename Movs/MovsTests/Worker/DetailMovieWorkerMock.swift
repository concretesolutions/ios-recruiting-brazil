//
//  DetailMovieWorkerMock.swift
//  MovsTests
//
//  Created by Maisa on 03/11/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

@testable import Movs

class DetailMovieWorkerMock: DetailMovieWorkerProtocol {
    
    let detailMovie = MovieDetailed(id: 123, genres: [Genre(id: 23, name: "genre")], genresNames: ["genre"], title: "title", overview: "overview", releaseDate: "2018-10-10", posterPath: "aaa", voteAverage: 8.0, isFavorite: true)
    var error: FetchError?

    func getMovieDetails(request: DetailMovieModel.Request,
                         success successCallback: @escaping (MovieDetailed) -> (),
                         error errorCallback: @escaping (FetchError) -> (),
                         failure failureCallback: @escaping (FetchError) -> ()) {
        if request.movieId == detailMovie.id {
            successCallback(detailMovie)
        } else { // Not able to find the id of the movie
            errorCallback(FetchError.serverError)
        }
        if let _ = error {
            failureCallback(FetchError.networkFailToConnect)
        } 
    }
    
    
}

