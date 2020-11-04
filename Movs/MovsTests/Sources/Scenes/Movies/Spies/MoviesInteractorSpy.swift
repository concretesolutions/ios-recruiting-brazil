//
//  MoviesInteractorSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 03/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class MoviesInteractorSpy: MoviesBusinessLogic {
    private(set) var invokedFetchLocalMovies = false
    private(set) var invokedFetchLocalMoviesCount = 0

    private(set) var invokedFetchGenres = false
    private(set) var invokedFetchGenresCount = 0
    private(set) var invokedFetchGenresParameters: (request: Movies.FetchGenres.Request, Void)?
    private(set) var invokedFetchGenresParametersList = [(request: Movies.FetchGenres.Request, Void)]()

    private(set) var invokedFetchMovies = false
    private(set) var invokedFetchMoviesCount = 0
    private(set) var invokedFetchMoviesParameters: (request: Movies.FetchMovies.Request, Void)?
    private(set) var invokedFetchMoviesParametersList = [(request: Movies.FetchMovies.Request, Void)]()

    private(set) var invokedFetchLocalMoviesBySearch = false
    private(set) var invokedFetchLocalMoviesBySearchCount = 0
    private(set) var invokedFetchLocalMoviesBySearchParameters: (request: Movies.FetchLocalMoviesBySearch.Request, Void)?
    private(set) var invokedFetchLocalMoviesBySearchParametersList = [(request: Movies.FetchLocalMoviesBySearch.Request, Void)]()

    // MARK: - MoviesBusinessLogic conforms

    func fetchLocalMovies() {
        invokedFetchLocalMovies = true
        invokedFetchLocalMoviesCount += 1
    }

    func fetchGenres(request: Movies.FetchGenres.Request) {
        invokedFetchGenres = true
        invokedFetchGenresCount += 1
        invokedFetchGenresParameters = (request, ())
        invokedFetchGenresParametersList.append((request, ()))
    }

    func fetchMovies(request: Movies.FetchMovies.Request) {
        invokedFetchMovies = true
        invokedFetchMoviesCount += 1
        invokedFetchMoviesParameters = (request, ())
        invokedFetchMoviesParametersList.append((request, ()))
    }

    func fetchLocalMoviesBySearch(request: Movies.FetchLocalMoviesBySearch.Request) {
        invokedFetchLocalMoviesBySearch = true
        invokedFetchLocalMoviesBySearchCount += 1
        invokedFetchLocalMoviesBySearchParameters = (request, ())
        invokedFetchLocalMoviesBySearchParametersList.append((request, ()))
    }
}
